Return-Path: <linux-nfs+bounces-13747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6BB2B199
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 21:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CB1B262BD
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9826E143;
	Mon, 18 Aug 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkw8dSf+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFE20C00B
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545278; cv=none; b=sgAcBKBqFy0wR+OW7NZR90EtGkfJYo/L3h/8xQfHInx1ClduMjg2icCN3wIP3nHXv44EDaEbJA5xC+Strt8Nc+BxUYWlMAFKlntKMGVtsuPtsXCs278obDwobop8UwamVgkVSwtAiW92cc7zc6/VjVjhWEGzqxeMbLif8ql/TNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545278; c=relaxed/simple;
	bh=opGCD/JR6Y/SHqLGtRX7sxzmX2B2KsfpnCqz35E93FQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fk8Dy0A0Y4l/egfR47HBa+TgIghNqksViCsvp8ET828NWz5dcOd/uWVJjV+NpH6fSTCMnFjVp4d3TBPK7JCIxnjeybz5lykX/47/9IG1c0Eyx+am+4D07GWXKdiHGwgPOwLm3dZ1roiEqeSV7okCby4mB1Fm4S4LY05jb2wFUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkw8dSf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAA8C4CEEB;
	Mon, 18 Aug 2025 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755545277;
	bh=opGCD/JR6Y/SHqLGtRX7sxzmX2B2KsfpnCqz35E93FQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Mkw8dSf+nxa2Nv8dKe6T+ni/6Ku6Jqm9Ijcg/EK3NEqgjVlt6Rmdze5Se/Fi/WdEH
	 imvMi7KnbTsA6XjG1vXY3AK7v259ToOC+MUjLZOSrEdyOXOFHmxfx9K4LTyNro91GP
	 Hd1QSgMZB3X6yJcNG3KrVKA4TUxYKttL0RnXdYKkiTlubM25NQYHJ3HGPslKEa3De+
	 H+MeJKhO6PNME7Aplv+12EVk0Vrs6pGz5gkN3vc9IOkZKHP8E+gB+dWKGoF8KIIb2k
	 RtO8Frl1Ls6ToGXiDa47s7os4JNGdLLOkgrQWlY9PU6b2ZCosTXEX8QKJxP76KHcDO
	 RbddtZvCNfvtg==
Message-ID: <eea0862de2cc9d9204527ddcbd9455422bcd042e.camel@kernel.org>
Subject: Re: [PATCH v7 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Mon, 18 Aug 2025 15:27:56 -0400
In-Reply-To: <aKN5Yy6Y08VozjwF@kernel.org>
References: <20250815144607.50967-1-snitzer@kernel.org>
	 <20250815144607.50967-6-snitzer@kernel.org>
	 <ddc5b0acc656a5f920fb494c420d8e79bd7681ab.camel@kernel.org>
	 <aKN5Yy6Y08VozjwF@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 15:05 -0400, Mike Snitzer wrote:
> On Mon, Aug 18, 2025 at 10:45:47AM -0400, Jeff Layton wrote:
> > On Fri, 2025-08-15 at 10:46 -0400, Mike Snitzer wrote:
> > > If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> > > DIO-aligned block (on either end of the READ). The expanded READ is
> > > verified to have proper offset/len (logical_block_size) and
> > > dma_alignment checking.
> > >=20
> > > Must allocate and use a bounce-buffer page (called 'start_extra_page'=
)
> > > if/when expanding the misaligned READ requires reading extra partial
> > > page at the start of the READ so that its DIO-aligned. Otherwise that
> > > extra page at the start will make its way back to the NFS client and
> > > corruption will occur. As found, and then this fix of using an extra
> > > page verified, using the 'dt' utility:
> > >   dt of=3D/mnt/share1/dt_a.test passes=3D1 bs=3D47008 count=3D2 \
> > >      iotype=3Dsequential pattern=3Diot onerr=3Dabort oncerr=3Dabort
> > > see: https://github.com/RobinTMiller/dt.git
> > >=20
> > > Any misaligned READ that is less than 32K won't be expanded to be
> > > DIO-aligned (this heuristic just avoids excess work, like allocating
> > > start_extra_page, for smaller IO that can generally already perform
> > > well using buffered IO).
> > >=20
> > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/vfs.c              | 200 +++++++++++++++++++++++++++++++++++=
--
> > >  include/linux/sunrpc/svc.h |   5 +-
> > >  2 files changed, 194 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index c340708fbab4d..64732dc8985d6 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/splice.h>
> > >  #include <linux/falloc.h>
> > >  #include <linux/fcntl.h>
> > > +#include <linux/math.h>
> > >  #include <linux/namei.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/fsnotify.h>
> > > @@ -1073,6 +1074,153 @@ __be32 nfsd_splice_read(struct svc_rqst *rqst=
p, struct svc_fh *fhp,
> > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_=
err);
> > >  }
> > > =20
> > > +struct nfsd_read_dio {
> > > +	loff_t start;
> > > +	loff_t end;
> > > +	unsigned long start_extra;
> > > +	unsigned long end_extra;
> > > +	struct page *start_extra_page;
> > > +};
> > > +
> > > +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
> > > +{
> > > +	memset(read_dio, 0, sizeof(*read_dio));
> > > +	read_dio->start_extra_page =3D NULL;
> > > +}
> > > +
> > > +#define NFSD_READ_DIO_MIN_KB (32 << 10)
> > > +
> > > +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> > > +				  struct nfsd_file *nf, loff_t offset,
> > > +				  unsigned long len, unsigned int base,
> > > +				  struct nfsd_read_dio *read_dio)
> > > +{
> > > +	const u32 dio_blocksize =3D nf->nf_dio_read_offset_align;
> > > +	loff_t middle_end, orig_end =3D offset + len;
> > > +
> > > +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_alig=
n,
> > > +		      "%s: underlying filesystem has not provided DIO alignment in=
fo\n",
> > > +		      __func__))
> > > +		return false;
> > > +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> > > +		      "%s: underlying storage's dio_blocksize=3D%u > PAGE_SIZE=3D%=
lu\n",
> > > +		      __func__, dio_blocksize, PAGE_SIZE))
> > > +		return false;
> > > +
> > > +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
> > > +	 * or base not aligned).
> > > +	 * Ondisk alignment is implied by the following code that expands
> > > +	 * misaligned IO to have a DIO-aligned offset and len.
> > > +	 */
> > > +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align=
-1)) !=3D 0))
> > > +		return false;
> >=20
> > The small len check makes sense, but "base" at this point is the offset
> > into the first page. Here you're bailing out early if that's not
> > aligned. Isn't that contrary to what this patch is supposed to do
> > (which is expand the range so that the I/O is aligned)?
>=20
> No matter whether we're expanding the read or not (that's a means to
> make the area read from disk DIO-aligned): the memory alignment is
> what it is -- so it isn't something that we can change (not without an
> extra copy). But thankfully with RDMA the memory for the READ payload
> is generally always aligned.
>=20
> Chcuk did say in reply to an earlier version of this patchset
> (paraphrasing, rather not go splunking in the linux-nfs archive to
> find it): a future improvement would be to make sure the READ
> payload's memory is always aligned.
>=20

Oh right, I got confused between the mem and block alignment here.

In light of that, you can add

Reviewed-by: Jeff Layton <jlayton@kernel.org>

