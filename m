Return-Path: <linux-nfs+bounces-13704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195FB290A7
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6EB1C21E27
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A741FBE80;
	Sat, 16 Aug 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6ahHLyr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20C1E1A17
	for <linux-nfs@vger.kernel.org>; Sat, 16 Aug 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755379530; cv=none; b=DGObZva6KkFg7cT4pzIBxXk5ESJKJRGxNMiqY66gpo0z871XLx6M/E1WTtEd+zk5ht9AmX2nLh+6bOrZd+N0nk+YYjpSkL8O1ABWvsfuAIi59QEellIwMLjh6uZKfYgiE5TofeooN7arulBPxqf7mz5GQbUEde/v2mI21d+CJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755379530; c=relaxed/simple;
	bh=zuTbOMzxM4dCuDSar1aj7fSwKFXEMnAZhvy5YfoXqHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar7ruJQpElGIw7tQRxmiXc2LWFUmXVIGi0a1/RwClj0i4daCkD6UyLiYiOZ3/QLWWv+WsfnPKnOb3EQ9wvqQsad+B9jjsNUI+o1GU0s7nk4axr79ElTagdC7TH1ELtZXZnas+aL6yFiSSLhxdB/H0R4OOys8w/0iuzylpOPRRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6ahHLyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF2C4CEEF;
	Sat, 16 Aug 2025 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755379530;
	bh=zuTbOMzxM4dCuDSar1aj7fSwKFXEMnAZhvy5YfoXqHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6ahHLyr6MnppyfAo9Mx9i0Dg6u39ssr7/BRRPnZhrYvyqvcuVxv2SUdPwdpauhML
	 jg/pUiaI8qINt1zuYmwu8eUcg5Y4T0qL8w8fwsmYG7ffDdq73l9bw5GvKKCSWgnpnu
	 FGyneUg4wKS9cVny4ORwelHbbZeUGNhjFsaoWHCH/Yxe0C2ODVcS14K2vDmcuw1rfU
	 946X+uJ9PIoylsCuBOAKqDlWELS+ted3IylSaKrGs3VJWyEGIjghfZiVHk595PTD4Y
	 edwBunknUWnKo/13s94PeCf+5z5cyMqYTlZMua1HdBDN9LzNR+VPdROcJZPnbVkooE
	 3+ZFiIF16N9LQ==
Date: Sat, 16 Aug 2025 17:25:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	jonathan.flynn@hammerspace.com
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
Message-ID: <aKD3SFcyCnb8snst@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
 <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
 <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2XDoF3yvYa3Qjteu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce7e7d92581a2d447f7c5e70b280431528d289aa.camel@kernel.org>


--2XDoF3yvYa3Qjteu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Aug 16, 2025 at 07:51:17AM -0700, Trond Myklebust wrote:
> On Sat, 2025-08-16 at 09:01 -0400, Jeff Layton wrote:
> > 
> > I finally caught something concrete today. I had the attached
> > bpftrace
> > script running while running the reproducer on a dozen or so
> > machines,
> > and it detected a hole in some data being written:
> > 
> > -------------8<---------------
> > Attached 2 probes
> > Missing nfs_page: ino=10122173116 idx=2 flags=0x15ffff0000000029
> > Hole: ino=10122173116 idx=3 off=10026 size=2262
> > Prev folio: idx=2 flags=0x15ffff0000000028 pgbase=0 bytes=4096 req=0
> > prevreq=0xffff8955b2f55980
> > -------------8<---------------
> > 
> > What this tells us is that the page at idx=2 got submitted to
> > nfs_do_writepage() (so it was marked dirty in the pagecache), but
> > when
> > it got there, folio->private was NULL and it was ignored.
> > 
> > The kernel in this case is based on v6.9, so it's (just) pre-large-
> > folio support. It has a fair number of NFS patches, but not much to
> > this portion of the code. Most of them are are containerization
> > fixes.
> > 
> > I'm looking askance at nfs_inode_remove_request(). It does this:
> > 
> >         if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> >                 struct folio *folio = nfs_page_to_folio(req-
> > >wb_head);
> >                 struct address_space *mapping = folio->mapping;
> > 
> >                 spin_lock(&mapping->i_private_lock);
> >                 if (likely(folio)) {
> >                         folio->private = NULL;
> >                         folio_clear_private(folio);
> >                         clear_bit(PG_MAPPED, &req->wb_head-
> > >wb_flags);
> >                 }
> >                 spin_unlock(&mapping->i_private_lock);
> >         }
> > 
> > If nfs_page_group_sync_on_bit() returns true, then the nfs_page gets
> > detached from the folio. Meanwhile, if a new write request comes in
> > just after that, nfs_lock_and_join_requests() will call
> > nfs_cancel_remove_inode() to try to "cancel" PG_REMOVE:
> > 
> > static int
> > nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> > {
> >         int ret;
> > 
> >         if (!test_bit(PG_REMOVE, &req->wb_flags))
> >                 return 0;
> >         ret = nfs_page_group_lock(req);
> >         if (ret)
> >                 return ret;
> >         if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> >                 nfs_page_set_inode_ref(req, inode);
> >         nfs_page_group_unlock(req);                          
> >         return 0;                                    
> > }                     
> > 
> > ...but that does not reattach the nfs_page to the folio. Should it?
> >                         
> 
> That's not sufficient AFAICS. Does the following patch work?
> 
> 8<------------------------------------------------------------
> From fc9690dda01f001c6cd11665701394da8ebba1ab Mon Sep 17 00:00:00 2001
> Message-ID: <fc9690dda01f001c6cd11665701394da8ebba1ab.1755355810.git.trond.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Sat, 16 Aug 2025 07:25:20 -0700
> Subject: [PATCH] NFS: Fix a race when updating an existing write
> 
> After nfs_lock_and_join_requests() tests for whether the request is
> still attached to the mapping, nothing prevents a call to
> nfs_inode_remove_request() from succeeding until we actually lock the
> page group.
> The reason is that whoever called nfs_inode_remove_request() doesn't
> necessarily have a lock on the page group head.
> 
> So in order to avoid races, let's take the page group lock earlier in
> nfs_lock_and_join_requests(), and hold it across the removal of the
> request in nfs_inode_remove_request().
> 
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/pagelist.c        |  9 +++++----
>  fs/nfs/write.c           | 29 ++++++++++-------------------
>  include/linux/nfs_page.h |  1 +
>  3 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 11968dcb7243..6e69ce43a13f 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
>  	nfs_page_clear_headlock(req);
>  }
>  
> -/*
> - * nfs_page_group_sync_on_bit_locked
> +/**
> + * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
> + * @req: request in page group
> + * @bit: PG_* bit that is used to sync page group
>   *
>   * must be called with page group lock held
>   */
> -static bool
> -nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
> +bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
>  {
>  	struct nfs_page *head = req->wb_head;
>  	struct nfs_page *tmp;
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index fa5c41d0989a..8b7c04737967 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
>  	}
>  }
>  
> -static int
> -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> +static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
>  {
> -	int ret;
> -
> -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> -		return 0;
> -	ret = nfs_page_group_lock(req);
> -	if (ret)
> -		return ret;
>  	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
>  		nfs_page_set_inode_ref(req, inode);
> -	nfs_page_group_unlock(req);
> -	return 0;
>  }
>  
>  /**
> @@ -585,19 +575,18 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
>  		}
>  	}
>  
> +	ret = nfs_page_group_lock(head);
> +	if (ret < 0)
> +		goto out_unlock;
> +
>  	/* Ensure that nobody removed the request before we locked it */
>  	if (head != folio->private) {
> +		nfs_page_group_unlock(head);
>  		nfs_unlock_and_release_request(head);
>  		goto retry;
>  	}
>  
> -	ret = nfs_cancel_remove_inode(head, inode);
> -	if (ret < 0)
> -		goto out_unlock;
> -
> -	ret = nfs_page_group_lock(head);
> -	if (ret < 0)
> -		goto out_unlock;
> +	nfs_cancel_remove_inode(head, inode);
>  
>  	/* lock each request in the page group */
>  	for (subreq = head->wb_this_page;
> @@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
>  {
>  	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
>  
> -	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
> +	nfs_page_group_lock(req);
> +	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
>  		struct folio *folio = nfs_page_to_folio(req->wb_head);
>  		struct address_space *mapping = folio->mapping;
>  
> @@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
>  		}
>  		spin_unlock(&mapping->i_private_lock);
>  	}
> +	nfs_page_group_unlock(req);
>  
>  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
>  		atomic_long_dec(&nfsi->nrequests);
> diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> index 169b4ae30ff4..9aed39abc94b 100644
> --- a/include/linux/nfs_page.h
> +++ b/include/linux/nfs_page.h
> @@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
>  extern int nfs_page_group_lock(struct nfs_page *);
>  extern void nfs_page_group_unlock(struct nfs_page *);
>  extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
> +extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
>  extern	int nfs_page_set_headlock(struct nfs_page *req);
>  extern void nfs_page_clear_headlock(struct nfs_page *req);
>  extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
> -- 
> 2.50.1
> 
> 


Trond,

You're the best! ;)

Your patch fixes corruption I've been chasing for the past week
relative to NFS DIRECT, specifically with:
echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_align_misaligned_IO

So you need my latest NFS DIRECT patchset:
https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kernel.org/

With it, writes would be corrupted when using the attached reproducer
(from Jon Flynn, with the assistance of ChatGPT) that pulls out the
subset of MLperf unet3d test (when ran in buffered IO mode, so
entirely misaligned relative to DIO-alignment requirements) that we've
seen npz CRC compare failure with.

I tested my patchset with your patch applied and it all "just works".

Ship it all!

Thanks,
Mike

ps. running the attached reproducer is as simple as:
./mlperf_npz_tool.py --npz-path /mnt/share1/sample_a.npz

--2XDoF3yvYa3Qjteu
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

    print(f"âœ… Wrote {out_path}")
    try:
        sz = out_path.stat().st_size
        print(f"   size={sz} bytes, x.shape={x.shape}, dtype={x.dtype}, samples={samples}")
    except FileNotFoundError:
        pass

def list_and_crc(npz_path: Path, deep=False):
    print(f"ðŸ“‚ File: {npz_path}")
    with zipfile.ZipFile(npz_path, "r") as zf:
        names = zf.namelist()
        print(f"ðŸ“¦ Files in archive: {names}\n")
        for name in names:
            info = zf.getinfo(name)
            print(f"--- {name} ---")
            print(f"Stored CRC32       : 0x{info.CRC:08x}")
            print(f"Compressed Size    : {info.compress_size}")
            print(f"Uncompressed Size  : {info.file_size}")
            try:
                with zf.open(info) as f:
                    _ = f.read()                 # will raise if CRC mismatch
                print("âœ… CRC verified by zipfile.\n")
            except zipfile.BadZipFile as e:
                print(f"âš ï¸ CRC error via zipfile: {e}")
                if deep:
                    ok = deep_crc_check(npz_path, info)
                    print("ðŸ”Ž Deep check      :", "âœ… OK\n" if ok else "âŒ Mismatch\n")
                else:
                    print("â„¹ï¸  Re-run with --deep-check to diagnose.\n")
            except Exception as e:
                print(f"âŒ Unexpected error: {e}\n")

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


--2XDoF3yvYa3Qjteu--

