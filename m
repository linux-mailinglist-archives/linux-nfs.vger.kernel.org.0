Return-Path: <linux-nfs+bounces-15621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29538C07C17
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53D5F4FE110
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94352E6CCC;
	Fri, 24 Oct 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P562tcjJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93243242D70
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330604; cv=none; b=uLPeTUpSA6yHcuTXtxgS9siCDvvz4JpqdFPZ+j2f0njgoruzZ2LSMMBucrSbIljXAmIM3UTK/sQ2H4g2vU/LnjoYSaCTLBonV/XZ9fSCmMhSr2rUGulanNDScBGVcZNcWRb9x5ZolFepXiHKwnHDrCNH3fL8E6Z4BMOfZT1nOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330604; c=relaxed/simple;
	bh=MdkK4AIxwGyYtFOfQv5ey85xhxyD/Ec77vKilq3IbLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4GUAtelawH945fVEMoMkLOlKUYsSownJDBXaNwblRRVzF6OVFjnbmN/rskbkhjyitkrcO175ULVOyEjsDgSIbC/y9sE6uv9GQHqnkLpaqJR69PNo745jgi4TT8yDBhApwcYlRKbcxj0h2XDf/MhWN4BPdFBes7piM7dL9qq/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P562tcjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D477EC4CEF7;
	Fri, 24 Oct 2025 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330604;
	bh=MdkK4AIxwGyYtFOfQv5ey85xhxyD/Ec77vKilq3IbLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P562tcjJnujbWH+4Z7tbol0jPptJ2nG7D6NDWQoiklDLo5xGSjPa0fd9/NlwbtcX5
	 mqKkdOFWHEx5fRzMk/dGAM1QOvPBNrlWJ63mZKet9D2wAbJTTeqFutkTwn9sBr5AR8
	 KuMr/+RmakiSIGRIMhBV92ReUAvEWdo/sNIfsr/Z7n4wi1krniv5UfU7r/kljmNlIX
	 VvOlpdzk904WX05y4RQwCvT6qzCbnP+S9apTpZCBKCsCBSwq9Bzw/vN1SXup6MzRp/
	 n5nGLMYHJ7E2KGLMmw2o4NJURLej3NWGMy6C+mpVVh0CovudnGzAvzmoAs6DrN0tKi
	 tCRWv+UebMy6g==
Date: Fri, 24 Oct 2025 14:30:02 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPvFqvtObywC2Bpt@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
 <33ee6dda-6b10-4a85-9346-5fc1bc6f2731@kernel.org>
 <aPqc0TPxVHRwq3og@kernel.org>
 <d23cf628-50f4-441b-af65-1553e09ba153@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wvqZMFiAS0tokqfg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d23cf628-50f4-441b-af65-1553e09ba153@kernel.org>


--wvqZMFiAS0tokqfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2025 at 10:24:41AM -0400, Chuck Lever wrote:
> On 10/23/25 5:23 PM, Mike Snitzer wrote:
> > On Thu, Oct 23, 2025 at 03:37:36PM -0400, Chuck Lever wrote:
> >> On 10/22/25 3:22 PM, Chuck Lever wrote:
> >>> +struct nfsd_write_dio {
> >>> +	ssize_t	start_len;	/* Length for misaligned first extent */
> >>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> >>> +	ssize_t	end_len;	/* Length for misaligned last extent */
> >>> +};
> >>> +
> >>> +static bool
> >>> +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> >>> +			   struct nfsd_file *nf,
> >>> +			   struct nfsd_write_dio *write_dio)
> >>> +{
> >>> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> >>> +	loff_t start_end, orig_end, middle_end;
> >>> +
> >>> +	if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
> >>> +		return false;
> >>> +
> >>> +	start_end = round_up(offset, dio_blocksize);
> >>> +	orig_end = offset + len;
> >>> +	middle_end = round_down(orig_end, dio_blocksize);
> >>> +
> >>> +	write_dio->start_len = start_end - offset;
> >>> +	write_dio->middle_len = middle_end - start_end;
> >>> +	write_dio->end_len = orig_end - middle_end;
> >>> +
> >>> +	return true;
> >>> +}
> >>> +
> >>> +static bool
> >>> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> >>> +			   unsigned int len_mask)
> >>> +{
> >>> +	const struct bio_vec *bvec = i->bvec;
> >>> +	size_t skip = i->iov_offset;
> >>> +	size_t size = i->count;
> >>> +
> >>> +	if (size & len_mask)
> >>> +		return false;
> >>> +	do {
> >>> +		size_t len = bvec->bv_len;
> >>> +
> >>> +		if (len > size)
> >>> +			len = size;
> >>> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> >>> +			return false;
> >>> +		bvec++;
> >>> +		size -= len;
> >>> +		skip = 0;
> >>> +	} while (size);
> >>> +
> >>> +	return true;
> >>> +}
> >>> +
> >>
> >> Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
> >> would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
> >> would return false.
> > 
> > It is always due to memory alignment (addr_mask check), never due to
> > logical alignment (len_mask check).
> > 
> > So we could remove the len_mask arg and the 'if (size & len_mask)'
> > check from nfsd_iov_iter_aligned_bvec
> 
> Fair enough.
> 
> Another question: why does nfsd_iov_iter_aligned_bvec need to walk the
> entire bvec? For current NFSD and SunRPC, the elements of the bvec
> array will be contiguous pages. After nfsd_is_write_dio_possible says
> "OK", seems like you need to check only the first element in the bvec?

I haven't analyzed if simply checking the first element of the bvec is
sufficient, that'd be a very welcomed efficiency improvement!.

I just know the checking to important and so when
iov_iter_aligned_bvec() removed by Keith I knew we still needed the
benefit of that checking.

> Or, maybe the check isn't necessary at all?

No, the memory alignment checking is certainly needed.  I've attached
the python reproducer that Jonathan Flynn coded (with ChatGPT assist,
hence the emoji like output ;) ) that really exposes the need for
memory alignment checking.

This python code effectively is the preliminary work done by the
MLperf benchmark to extract npz files as executed using MLperf's
buffered IO mode at the client.  (MLperf _can_ be executed in DIO mode
and when that is used there is no resulting misaligned memory).

Run it with:
./mlperf_npz_tool.py --npz-path /mnt/share1/test.npz

> I'm just wondering why nfsd_is_write_dio_possible by itself isn't
> sufficient. Our network transports aren't going to hand us arbitrary
> blobs in the bvec elements.

Sure, would be great if simply checking the first element sufficient.

Thanks,
Mike

--wvqZMFiAS0tokqfg
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="mlperf_npz_tool.py"
Content-Transfer-Encoding: 8bit

#!/usr/bin/env python3
import argparse, math, os, struct, zlib
from pathlib import Path
import numpy as np
import zipfile

# -----------------------
# Defaults (from your YAML)
# -----------------------
DEFAULT_MEAN_BYTES  = 146_600_628
DEFAULT_STDEV_BYTES = 68_341_808
DEFAULT_RESIZE      = 2_097_152     # 2 MiB
DEFAULT_SAMPLES     = 1
DEFAULT_DTYPE       = "uint8"
DEFAULT_SEED        = 10

# -----------------------
# Helpers
# -----------------------
DTYPE_SIZES = {
    "uint8": 1, "int8": 1,
    "uint16": 2, "int16": 2,
    "uint32": 4, "int32": 4,
    "float32": 4, "float64": 8,
}

def choose_target_bytes(mean_b, stdev_b, resize, randomize):
    if randomize and stdev_b > 0:
        draw = int(np.random.normal(loc=mean_b, scale=stdev_b))
        draw = max(draw, 1)
    else:
        draw = int(mean_b)
    # Round to nearest multiple of resize
    return int(round(draw / resize) * resize)

def choose_hw_for_bytes(total_bytes, samples, dtype_size):
    """
    Choose H, W making H*W*samples*dtype_size == total_bytes.
    We factor total elements and spread powers of two across H and W
    to avoid super-skinny arrays.
    """
    total_elems = total_bytes // (dtype_size * samples)
    if total_elems == 0:
        raise ValueError("Total elements computed as 0; check inputs.")
    n = total_elems
    # Factor out powers of two
    exp2 = (n & -n).bit_length() - 1
    odd  = n >> exp2
    h = 1 << (exp2 // 2)
    w = (1 << (exp2 - exp2 // 2)) * odd
    return int(h), int(w)

def save_npz(out_path: Path, *, mean_bytes, stdev_bytes, resize_bytes,
             samples, dtype_name, seed, compress, randomize):
    dtype = getattr(np, dtype_name)
    dtype_size = DTYPE_SIZES[dtype_name]

    np.random.seed(seed)
    target_bytes = choose_target_bytes(mean_bytes, stdev_bytes, resize_bytes, randomize)
    # Ensure divisibility:
    elems_per_sample = target_bytes // dtype_size // samples
    if elems_per_sample * dtype_size * samples != target_bytes:
        raise ValueError("Target bytes not divisible by dtype_size*samples; adjust params.")

    h, w = choose_hw_for_bytes(target_bytes, samples, dtype_size)

    x = np.random.randint(255, size=(h, w, samples), dtype=dtype if dtype_name == "uint8" else np.uint8)
    if dtype_name != "uint8":
        x = x.astype(dtype, copy=False)
    y = np.zeros((samples,), dtype=np.uint8)  # matches DLIO NPZ generator convention

    out_path.parent.mkdir(parents=True, exist_ok=True)
    if compress:
        np.savez_compressed(out_path, x=x, y=y)
    else:
        np.savez(out_path, x=x, y=y)

    print(f"✅ Wrote {out_path}")
    try:
        sz = out_path.stat().st_size
        print(f"   size={sz} bytes, x.shape={x.shape}, dtype={x.dtype}, samples={samples}")
    except FileNotFoundError:
        pass

def list_and_crc(npz_path: Path, deep=False):
    print(f"📂 File: {npz_path}")
    with zipfile.ZipFile(npz_path, "r") as zf:
        names = zf.namelist()
        print(f"📦 Files in archive: {names}\n")
        for name in names:
            info = zf.getinfo(name)
            print(f"--- {name} ---")
            print(f"Stored CRC32       : 0x{info.CRC:08x}")
            print(f"Compressed Size    : {info.compress_size}")
            print(f"Uncompressed Size  : {info.file_size}")
            try:
                with zf.open(info) as f:
                    _ = f.read()                 # will raise if CRC mismatch
                print("✅ CRC verified by zipfile.\n")
            except zipfile.BadZipFile as e:
                print(f"⚠️ CRC error via zipfile: {e}")
                if deep:
                    ok = deep_crc_check(npz_path, info)
                    print("🔎 Deep check      :", "✅ OK\n" if ok else "❌ Mismatch\n")
                else:
                    print("ℹ️  Re-run with --deep-check to diagnose.\n")
            except Exception as e:
                print(f"❌ Unexpected error: {e}\n")

def deep_crc_check(npz_path: Path, info: zipfile.ZipInfo) -> bool:
    """
    Manual CRC of the *uncompressed* payload.
    Parse the local file header to find the compressed bytes, then
    decompress and compute CRC32 of the uncompressed stream.
    """
    with npz_path.open("rb") as fh:
        fh.seek(info.header_offset)
        local = fh.read(30)  # fixed part of local header
        # local file header sig 'PK\x03\x04'
        if local[:4] != b'PK\x03\x04':
            return False
        # filename length, extra length
        name_len, extra_len = struct.unpack("<HH", local[26:30])
        fh.seek(info.header_offset + 30 + name_len + extra_len)
        comp = fh.read(info.compress_size)

    # Decompress if needed
    if info.compress_type == zipfile.ZIP_STORED:
        data = comp
    elif info.compress_type == zipfile.ZIP_DEFLATED:
        # ZIP uses raw DEFLATE stream (no zlib header): wbits = -15
        try:
            data = zlib.decompress(comp, -15)
        except zlib.error:
            # Some writers include zlib headers; try normal
            data = zlib.decompress(comp)
    else:
        # Other methods not handled here
        return False

    crc = zlib.crc32(data) & 0xFFFFFFFF
    print(f"Computed CRC32     : 0x{crc:08x}")
    return crc == info.CRC

# -----------------------
# CLI
# -----------------------
def parse_args():
    p = argparse.ArgumentParser(description="MLPerf-style NPZ save & check tool")
    mode = p.add_mutually_exclusive_group()
    mode.add_argument("--save-only", action="store_true", help="Only save the NPZ")
    mode.add_argument("--check-only", action="store_true", help="Only verify/show the NPZ")

    p.add_argument("--npz-path", type=Path, help="Full output/check path to NPZ (overrides --out-dir/--name)")
    p.add_argument("--out-dir", type=Path, default=Path("/mnt/hs_test"), help="Directory for output NPZ")
    p.add_argument("--name", default="sample_000000.npz", help="Filename for output NPZ")
    p.add_argument("--compress", action="store_true", help="Use compressed NPZ (deflate)")

    # Size/dtype controls
    p.add_argument("--mean-bytes", type=int, default=DEFAULT_MEAN_BYTES, help="record_length_bytes")
    p.add_argument("--stdev-bytes", type=int, default=DEFAULT_STDEV_BYTES, help="record_length_bytes_stdev")
    p.add_argument("--resize-bytes", type=int, default=DEFAULT_RESIZE, help="record_length_bytes_resize multiple")
    p.add_argument("--randomize", action="store_true", help="Draw size from N(mean,stdev) before rounding")
    p.add_argument("--samples", type=int, default=DEFAULT_SAMPLES, help="num_samples_per_file")
    p.add_argument("--dtype", choices=DTYPE_SIZES.keys(), default=DEFAULT_DTYPE, help="Data dtype for 'x'")
    p.add_argument("--seed", type=int, default=DEFAULT_SEED, help="RNG seed for reproducibility")

    # Check controls
    p.add_argument("--deep-check", action="store_true", help="When checking, manually parse & CRC the member data")
    return p.parse_args()

def main():
    args = parse_args()
    out_path = args.npz_path or (args.out_dir / args.name)

    did_save = False
    if not args.check_only:
        save_npz(
            out_path=out_path,
            mean_bytes=args.mean_bytes,
            stdev_bytes=args.stdev_bytes,
            resize_bytes=args.resize_bytes,
            samples=args.samples,
            dtype_name=args.dtype,
            seed=args.seed,
            compress=args.compress,
            randomize=args.randomize,
        )
        did_save = True

    if not args.save_only:
        if not out_path.exists():
            raise SystemExit(f"File not found for check: {out_path}")
        list_and_crc(out_path, deep=args.deep_check)
    elif did_save:
        # echo path for easy piping
        print(out_path)

if __name__ == "__main__":
    main()


--wvqZMFiAS0tokqfg--

