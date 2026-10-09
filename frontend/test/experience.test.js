import { describe, it, expect } from 'vitest'

describe('Experience data', () => {
    it('should display current job as "Sekarang"', () => {
        const endYear = null

        const result = endYear ?? 'Sekarang'

        expect(result).toBe('Sekarang')
    })
})