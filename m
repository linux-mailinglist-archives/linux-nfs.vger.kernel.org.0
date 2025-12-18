Return-Path: <linux-nfs+bounces-17180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D60CCB30E
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D25130146D9
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612C330339;
	Thu, 18 Dec 2025 09:34:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7E3321D7
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050483; cv=none; b=EGOmsjxi2wc0epwpXvoJ1Y6Qfy+NLpoIRuqPaO9Hy4PsqWIx+4NBr27djEW62TvG/yMee4bE0f8v8VA04MPIDHKNc3WGuQv/kZjAZtx/Cql5EREfXP2XHV+4cRCpPgRyUfT+0461gUI7plQ1z0TW3tHUYFBjTabDHi6aPSAR12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050483; c=relaxed/simple;
	bh=7+UXJ7f3xVMzZUER/OK98u46ZxnTEzCaN0CjgD5OqBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx+K0JXUEX+JDxI3/4NfbGNW+5Cc7gO+pjzKl1lt7AX3GGrWdSjxv0R5KnK6mVtbL42qihDwRP4A6qEb5yquBl0SL/Khn2rA/+rS29+AKLCRhR+Vw91NZGlsvfUAZOOheARMIZMIU1b1bQ8XyofllguTbvUYF55Au03J86QQ92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCD25227A88; Thu, 18 Dec 2025 10:34:34 +0100 (CET)
Date: Thu, 18 Dec 2025 10:34:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent
 SCSI registration keys
Message-ID: <20251218093434.GB9235@lst.de>
References: <20251215181418.2201035-1-dai.ngo@oracle.com> <20251215181418.2201035-3-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215181418.2201035-3-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 15, 2025 at 10:13:34AM -0800, Dai Ngo wrote:
> +
> +int
> +nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
> +{
> +	int ix;
> +
> +	nn->client_pr_record_hashtbl = kmalloc_array(CLIENT_HASH_SIZE,
> +					sizeof(struct list_head),
> +					GFP_KERNEL);
> +	if (!nn->client_pr_record_hashtbl)
> +		return -ENOMEM;
> +	spin_lock_init(&nn->client_pr_record_hashtbl_lock);
> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++)
> +		INIT_LIST_HEAD(&nn->client_pr_record_hashtbl[ix]);
> +	return 0;

I guess there is precendent in the nfsd code in using this fixed size
hash table, but they are not very scalable.  And using the rhastable
API is actually relatively simple, so it might be easier to use that
than rolling your own hash.

If you stick to the fixes size open code hash, you should use a
hlist_head here.  There is no advantage in having a pointer to the tail
entry for hashes, and the hlist saves half of the memory usage and
improves cache efficiency.

But taking a step back:  why do we even need a new hash table here?
Can't we jut hang off a list of block device for which a layout
was granted off the nfs4_client structure given that we already
have it available?

> +static struct scsi_pr_record *
> +nfsd4_pr_find_client(struct nfs4_client *clp, struct block_device *blkdev)
> +{
> +	struct scsi_pr_record *pr_rec = NULL;
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +	unsigned int idhashval;
> +	dev_t bdev = blkdev->bd_dev;
> +
> +	assert_spin_locked(&nn->client_pr_record_hashtbl_lock);
> +	idhashval = clientid_hashval(clp->cl_clientid.cl_id);
> +	list_for_each_entry(pr_rec, &nn->client_pr_record_hashtbl[idhashval],
> +					spr_hash) {
> +		if (same_clid(&pr_rec->spr_clid, &clp->cl_clientid) &&
> +				pr_rec->spr_bdev == bdev) {
> +			return pr_rec;
> +		}

This ensures that you always have collisions for multiple bdevs of the
same client.  Why not use a hash the mixes entropy from the client id
and the bdev?

> +bool
> +nfsd4_scsi_pr_fence(struct nfs4_client *clp, struct block_device *blkdev)
> +{
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +	struct scsi_pr_record *rec;
> +
> +	assert_spin_locked(&nn->client_pr_record_hashtbl_lock);
> +	rec = nfsd4_pr_find_client(clp, blkdev);
> +	if (rec && !rec->spr_fenced) {
> +		rec->spr_fenced = true;
> +		return true;
> +	}
> +	return false;
> +}

This function seems misnamed.  It doesn't do any actualy fencing.

> +extern int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *net);
> +extern void nfsd4_scsi_pr_shutdown(struct nfsd_net *net);
> +struct nfs4_client;
> +extern void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);
> +extern int nfsd4_scsi_pr_add_client(struct nfs4_client *clp,
> +		struct block_device *blkdev);
> +extern bool nfsd4_scsi_pr_fence(struct nfs4_client *clp,
> +		struct block_device *blkdev);

Some of these are only used inside of blocklayout, so mark them
static.  For the others drop the extern.  Also please keep
struct forward declarations at the top of the file.

> +
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> @@ -578,6 +587,13 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
>  
>  static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>  
> +extern inline int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)

This should be static inline.

> index db9af780438b..9ae02b6d922d 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -67,6 +67,17 @@ __be32 nfsd4_return_client_layouts(struct svc_rqst *rqstp,
>  int nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
>  		u32 device_generation);
>  struct nfsd4_deviceid_map *nfsd4_find_devid_map(int idx);
> +
> +int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn);
> +void nfsd4_scsi_pr_shutdown(struct nfsd_net *nn);
> +void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);

These duplicate the prototypes in nfsd.h.

> +struct scsi_pr_record {
> +	struct list_head spr_hash;
> +	clientid_t spr_clid;
> +	dev_t spr_bdev;
> +	bool spr_fenced;
> +};

This can be kept static in blocklayout.c


