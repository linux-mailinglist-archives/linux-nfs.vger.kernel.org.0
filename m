Return-Path: <linux-nfs+bounces-12500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731D3ADBCC7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 00:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672AB164348
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0A2211A15;
	Mon, 16 Jun 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="heZpteoM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF34A0C
	for <linux-nfs@vger.kernel.org>; Mon, 16 Jun 2025 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112570; cv=none; b=RMOGAHBoprRmDSriB0XMRfEi6D7q68+U4UY+m1v5rgW4nioo8oj4pIcQh1ieC/c3firDOYyTahnovuznQW/8hOhtUYqYu8vRfe4GmR3hV4QUKt1i5Ci3MruttNS/u0o2OMaXPVLkpAyjmUFB8w0foacyGyWOylJem87idETzXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112570; c=relaxed/simple;
	bh=X1/uMb6wZCYcYa2PdGzXIAa4qE7w6K8/+v5EqoXl+FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md/og1v1QMJtVs01xoRNQP34K4Q28NqhxIYOHdUUrwrYTy1vqZ73SXodgJOHUBzOCGy5/yyDAEamrCDobbwZ24CHLQCx6inGjldTZ+i0LJ480S50pTF/fIMggIQ0GMU9u9rY2j/kRwlvfonJslE+MPd+SZFO7Qg/GHPlwHq1J6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=heZpteoM; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id R5csunxoOVkcRRIDxuCPEX; Mon, 16 Jun 2025 22:22:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RIDwuJTXqZ6h1RIDwuhoZX; Mon, 16 Jun 2025 22:22:41 +0000
X-Authority-Analysis: v=2.4 cv=ergUzZpX c=1 sm=1 tr=0 ts=68509931
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=5hez1h7-0CAW91-6plQA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U8rVBteLc4Rem4z1pO4cCnL2hIFp3myIDLk6a0UVs/A=; b=heZpteoMbsRz4R4z/MLJ59dORK
	6Rgk/9NOqXhBLy0FoWi7AQfCSO49E/nxS6C2Eh1x3ZoQNkBlxIIAORS2RzkjOhQD5Y4FyronMZa1F
	oXdLVsEjiyC1Ogb1dMzcdPPuodyfAEk1/wsKqNUxZNxk4Pw8MTmQR+q+1s6A+49GCoF16d9IP3CwN
	eEmb2VO5usdFexYVf1/nBCFvmgKOVHQCPxmvZVlypaYdmQ9btoJmysSVvVoq1yub5CsqO0B6egeNW
	RGNZ26piNWEfOjf8mQTB0Ii232cZiorwzEDzmMcdE/H9aMRCxE+wMKdCanMPUB3XnNRqpOjI9oCwr
	dyimi/2Q==;
Received: from [177.238.16.137] (port=50416 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uRIDv-00000003p0w-3C3o;
	Mon, 16 Jun 2025 17:22:39 -0500
Message-ID: <97c86b90-76b2-483a-a649-c115ffe22213@embeddedor.com>
Date: Mon, 16 Jun 2025 16:22:32 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] NFSD: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Chuck Lever <chuck.lever@oracle.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aEoKCuQ1YDs2Ivn0@kspp>
 <4bb48a2d-5599-4728-b909-bbbaba2b33ee@oracle.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <4bb48a2d-5599-4728-b909-bbbaba2b33ee@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uRIDv-00000003p0w-3C3o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.16.137]:50416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBKbkDOPjB81YY1ocvVvIMyuNqKcipD54kNRy+Y5RRDalU59LRE/txwgo66cuiJFlMC97E0wFi8GLb8z/zNDSwezdrjcxNBA80e0x8KP5LnK2cg1lmpU
 qD9y/9VjR4L8Y8xD/uAglaFFN626dDdeFrDJPH7zzrYc6eb/QFl39o5AGYsxhD36I4LeDrfon8wNaFJf/lCM1vXT910j9lTigfM=



On 16/06/25 14:30, Chuck Lever wrote:
> On 6/11/25 6:58 PM, Gustavo A. R. Silva wrote:
>> Update `struct knfsd_fh` to use indices into the `fh_raw` array,
>> allowing removal of the flexible-array member `fh_fsid[]`. Refactor
>> related code accordingly.
>>
>> With this changes, fix many instances of the following type of
>> warnings:
>>
>> fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> fs/nfsd/state.h:763:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> fs/nfsd/state.h:669:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> fs/nfsd/state.h:549:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Co-developed-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>   - Use indices into `fh_raw`. (Christoph)
>>   - Remove union and flexible-array member `fh_fsid`. (Christoph)
>>
>> v1:
>>   - Link: https://lore.kernel.org/linux-hardening/aBp37ZXBJM09yAXp@kspp/
> 
> I prefer Neil's solution to address just the "flexible array member"
> warnings.
> 
> The intent in struct knfsd_fh was that fh_fsid was to fill up the rest
> of that arm of the union; it is not flexible in size.
> 
> Would it be enough to replace:
> 
> 	u32	fh_fsid[];	/* flexible-array member */
> 
> with:
> 
> 	u32	fh_fsid[NFS4_FHSIZE / 4 - 1];

Yep, this works --I'll send this as v3, then.

> 
> or:
> 
> 	u32	fh_fsid[0];

Zero-length arrays are deprecated under these scenarios because they lie
to the compiler, and we don't want that.

> 
> ?
> 
> 
> I agree that packing the u8 fields in a struct/union combination and
> then putting the octets directly onto the wire, as is currently done, is
> asking for trouble. However, replacing the union, as Christoph
> suggested, is a clean-up that ought to be done over time in multiple
> patches so that it is done mechanically (perhaps via cocchinelle) and
> can be bisected over if needed.
> 
> I might even want to see helper functions to access those fields, rather
> than poking them by symbolic offset into an array. Using accessor
> functions is definitely appropriate for the nfs4layouts.c consumer of
> knfsd_fh.
> 
> 
>>   fs/nfsd/export.c      |  2 +-
>>   fs/nfsd/export.h      |  2 +-
>>   fs/nfsd/nfs4layouts.c | 10 ++++----
>>   fs/nfsd/nfsfh.c       | 58 +++++++++++++++++++++++--------------------
>>   fs/nfsd/nfsfh.h       | 30 +++++++++++-----------
>>   5 files changed, 52 insertions(+), 50 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index 88ae410b4113..654d54a7148f 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -1231,7 +1231,7 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
>>   struct svc_export *
>>   rqst_exp_find(struct cache_req *reqp, struct net *net,
>>   	      struct auth_domain *cl, struct auth_domain *gsscl,
>> -	      int fsid_type, u32 *fsidv)
>> +	      int fsid_type, void *fsidv)
>>   {
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>   	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
>> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
>> index 4d92b99c1ffd..9b2719d8a3e2 100644
>> --- a/fs/nfsd/export.h
>> +++ b/fs/nfsd/export.h
>> @@ -131,6 +131,6 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
>>   }
>>   struct svc_export *rqst_exp_find(struct cache_req *reqp, struct net *net,
>>   				 struct auth_domain *cl, struct auth_domain *gsscl,
>> -				 int fsid_type, u32 *fsidv);
>> +				 int fsid_type, void *fsidv);
>>   
>>   #endif /* NFSD_EXPORT_H */
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index 290271ac4245..6dcd2c9ec15b 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -56,7 +56,7 @@ static void
>>   nfsd4_alloc_devid_map(const struct svc_fh *fhp)
>>   {
>>   	const struct knfsd_fh *fh = &fhp->fh_handle;
>> -	size_t fsid_len = key_len(fh->fh_fsid_type);
>> +	size_t fsid_len = key_len(fh->fh_raw[FH_FSID_TYPE]);
>>   	struct nfsd4_deviceid_map *map, *old;
>>   	int i;
>>   
>> @@ -64,8 +64,8 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
>>   	if (!map)
>>   		return;
>>   
>> -	map->fsid_type = fh->fh_fsid_type;
>> -	memcpy(&map->fsid, fh->fh_fsid, fsid_len);
>> +	map->fsid_type = fh->fh_raw[FH_FSID_TYPE];
>> +	memcpy(&map->fsid, fh->fh_raw + FH_FSID, fsid_len);
>>   
>>   	spin_lock(&nfsd_devid_lock);
>>   	if (fhp->fh_export->ex_devid_map)
>> @@ -73,9 +73,9 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
>>   
>>   	for (i = 0; i < DEVID_HASH_SIZE; i++) {
>>   		list_for_each_entry(old, &nfsd_devid_hash[i], hash) {
>> -			if (old->fsid_type != fh->fh_fsid_type)
>> +			if (old->fsid_type != map->fsid_type)
>>   				continue;
>> -			if (memcmp(old->fsid, fh->fh_fsid,
>> +			if (memcmp(old->fsid, map->fsid,
>>   					key_len(old->fsid_type)))
>>   				continue;
>>   
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index aef474f1b84b..01ff91a28fb6 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>> @@ -161,37 +161,40 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>>   	if (fh->fh_size == 0)
>>   		return nfserr_nofilehandle;
>>   
>> -	if (fh->fh_version != 1)
>> +	if (fh->fh_raw[FH_VERSION] != 1)
>>   		return error;
>>   
>>   	if (--data_left < 0)
>>   		return error;
>> -	if (fh->fh_auth_type != 0)
>> +	if (fh->fh_raw[FH_AUTH_TYPE] != 0)
>>   		return error;
>> -	len = key_len(fh->fh_fsid_type) / 4;
>> +	len = key_len(fh->fh_raw[FH_FSID_TYPE]) / 4;
>>   	if (len == 0)
>>   		return error;
>> -	if (fh->fh_fsid_type == FSID_MAJOR_MINOR) {
>> +	if (fh->fh_raw[FH_FSID_TYPE] == FSID_MAJOR_MINOR) {
>>   		/* deprecated, convert to type 3 */
>> +		u32 *fsidv = (u32 *)(fh->fh_raw + FH_FSID);
>> +
>>   		len = key_len(FSID_ENCODE_DEV)/4;
>> -		fh->fh_fsid_type = FSID_ENCODE_DEV;
>> +		fh->fh_raw[FH_FSID_TYPE] = FSID_ENCODE_DEV;
>>   		/*
>>   		 * struct knfsd_fh uses host-endian fields, which are
>>   		 * sometimes used to hold net-endian values. This
>>   		 * confuses sparse, so we must use __force here to
>>   		 * keep it from complaining.
>>   		 */
>> -		fh->fh_fsid[0] = new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_fsid[0]),
>> -						      ntohl((__force __be32)fh->fh_fsid[1])));
>> -		fh->fh_fsid[1] = fh->fh_fsid[2];
>> +		fsidv[0] = new_encode_dev(MKDEV(
>> +			ntohl((__force __be32)fsidv[0]),
>> +			ntohl((__force __be32)fsidv[1])));
>> +		fsidv[1] = fsidv[2];
>>   	}
>>   	data_left -= len;
>>   	if (data_left < 0)
>>   		return error;
>>   	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
>>   			    net, client, gssclient,
>> -			    fh->fh_fsid_type, fh->fh_fsid);
>> -	fid = (struct fid *)(fh->fh_fsid + len);
>> +			    fh->fh_raw[FH_FSID_TYPE], fh->fh_raw + FH_FSID);
>> +	fid = (struct fid *)(fh->fh_raw + FH_FSID + len);
>>   
>>   	error = nfserr_stale;
>>   	if (IS_ERR(exp)) {
>> @@ -233,7 +236,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>>   	 */
>>   	error = nfserr_badhandle;
>>   
>> -	fileid_type = fh->fh_fileid_type;
>> +	fileid_type = fh->fh_raw[FH_FILEID_TYPE];
>>   
>>   	if (fileid_type == FILEID_ROOT)
>>   		dentry = dget(exp->ex_path.dentry);
>> @@ -463,18 +466,19 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
>>   {
>>   	if (dentry != exp->ex_path.dentry) {
>>   		struct fid *fid = (struct fid *)
>> -			(fhp->fh_handle.fh_fsid + fhp->fh_handle.fh_size/4 - 1);
>> +			(fhp->fh_handle.fh_raw + FH_FSID +
>> +			 fhp->fh_handle.fh_size - 1);
>>   		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
>>   		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
>>   				EXPORT_FH_CONNECTABLE;
>>   		int fileid_type =
>>   			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
>>   
>> -		fhp->fh_handle.fh_fileid_type =
>> +		fhp->fh_handle.fh_raw[FH_FILEID_TYPE] =
>>   			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>>   		fhp->fh_handle.fh_size += maxsize * 4;
>>   	} else {
>> -		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
>> +		fhp->fh_handle.fh_raw[FH_FILEID_TYPE] = FILEID_ROOT;
>>   	}
>>   }
>>   
>> @@ -520,8 +524,8 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
>>   retry:
>>   	version = 1;
>>   	if (ref_fh && ref_fh->fh_export == exp) {
>> -		version = ref_fh->fh_handle.fh_version;
>> -		fsid_type = ref_fh->fh_handle.fh_fsid_type;
>> +		version = ref_fh->fh_handle.fh_raw[FH_VERSION];
>> +		fsid_type = ref_fh->fh_handle.fh_raw[FH_FSID_TYPE];
>>   
>>   		ref_fh = NULL;
>>   
>> @@ -562,9 +566,9 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
>>   		fsid_type = FSID_ENCODE_DEV;
>>   	else
>>   		fsid_type = FSID_DEV;
>> -	fhp->fh_handle.fh_version = version;
>> +	fhp->fh_handle.fh_raw[FH_VERSION] = version;
>>   	if (version)
>> -		fhp->fh_handle.fh_fsid_type = fsid_type;
>> +		fhp->fh_handle.fh_raw[FH_FSID_TYPE] = fsid_type;
>>   }
>>   
>>   __be32
>> @@ -610,18 +614,18 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
>>   	fhp->fh_export = exp_get(exp);
>>   
>>   	fhp->fh_handle.fh_size =
>> -		key_len(fhp->fh_handle.fh_fsid_type) + 4;
>> -	fhp->fh_handle.fh_auth_type = 0;
>> +		key_len(fhp->fh_handle.fh_raw[FH_FSID_TYPE]) + 4;
>> +	fhp->fh_handle.fh_raw[FH_AUTH_TYPE] = 0;
>>   
>> -	mk_fsid(fhp->fh_handle.fh_fsid_type,
>> -		fhp->fh_handle.fh_fsid,
>> +	mk_fsid(fhp->fh_handle.fh_raw[FH_FSID_TYPE],
>> +		fhp->fh_handle.fh_raw + FH_FSID,
>>   		ex_dev,
>>   		d_inode(exp->ex_path.dentry)->i_ino,
>>   		exp->ex_fsid, exp->ex_uuid);
>>   
>>   	if (inode)
>>   		_fh_update(fhp, exp, dentry);
>> -	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
>> +	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] == FILEID_INVALID) {
>>   		fh_put(fhp);
>>   		return nfserr_stale;
>>   	}
>> @@ -644,11 +648,11 @@ fh_update(struct svc_fh *fhp)
>>   	dentry = fhp->fh_dentry;
>>   	if (d_really_is_negative(dentry))
>>   		goto out_negative;
>> -	if (fhp->fh_handle.fh_fileid_type != FILEID_ROOT)
>> +	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] != FILEID_ROOT)
>>   		return 0;
>>   
>>   	_fh_update(fhp, fhp->fh_export, dentry);
>> -	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
>> +	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] == FILEID_INVALID)
>>   		return nfserr_stale;
>>   	return 0;
>>   out_bad:
>> @@ -776,9 +780,9 @@ char * SVCFH_fmt(struct svc_fh *fhp)
>>   
>>   enum fsid_source fsid_source(const struct svc_fh *fhp)
>>   {
>> -	if (fhp->fh_handle.fh_version != 1)
>> +	if (fhp->fh_handle.fh_raw[FH_VERSION] != 1)
>>   		return FSIDSOURCE_DEV;
>> -	switch(fhp->fh_handle.fh_fsid_type) {
>> +	switch (fhp->fh_handle.fh_raw[FH_FSID_TYPE]) {
>>   	case FSID_DEV:
>>   	case FSID_ENCODE_DEV:
>>   	case FSID_MAJOR_MINOR:
>> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
>> index 5103c2f4d225..26975ede465a 100644
>> --- a/fs/nfsd/nfsfh.h
>> +++ b/fs/nfsd/nfsfh.h
>> @@ -43,22 +43,17 @@
>>    *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
>>    *   in include/linux/exportfs.h for currently registered values.
>>    */
>> -
>>   struct knfsd_fh {
>>   	unsigned int	fh_size;	/*
>>   					 * Points to the current size while
>>   					 * building a new file handle.
>>   					 */
>> -	union {
>> -		char			fh_raw[NFS4_FHSIZE];
>> -		struct {
>> -			u8		fh_version;	/* == 1 */
>> -			u8		fh_auth_type;	/* deprecated */
>> -			u8		fh_fsid_type;
>> -			u8		fh_fileid_type;
>> -			u32		fh_fsid[]; /* flexible-array member */
>> -		};
>> -	};
>> +	char		fh_raw[NFS4_FHSIZE];
>> +#define FH_VERSION		0
>> +#define FH_AUTH_TYPE		1
>> +#define FH_FSID_TYPE		2
>> +#define FH_FILEID_TYPE		3
>> +#define FH_FSID			4
>>   };
>>   
>>   static inline __u32 ino_t_to_u32(ino_t ino)
>> @@ -141,10 +136,12 @@ extern enum fsid_source fsid_source(const struct svc_fh *fhp);
>>    * sparse from complaining. Since these values are opaque to the
>>    * client, that shouldn't be a problem.
>>    */
>> -static inline void mk_fsid(int vers, u32 *fsidv, dev_t dev, ino_t ino,
>> -			   u32 fsid, unsigned char *uuid)
>> +static inline void mk_fsid(int vers, void *fsid, dev_t dev, ino_t ino,
>> +			   u32 fsid_num, unsigned char *uuid)
>>   {
>> +	u32 *fsidv = fsid;
>>   	u32 *up;
>> +
>>   	switch(vers) {
>>   	case FSID_DEV:
>>   		fsidv[0] = (__force __u32)htonl((MAJOR(dev)<<16) |
>> @@ -152,7 +149,7 @@ static inline void mk_fsid(int vers, u32 *fsidv, dev_t dev, ino_t ino,
>>   		fsidv[1] = ino_t_to_u32(ino);
>>   		break;
>>   	case FSID_NUM:
>> -		fsidv[0] = fsid;
>> +		fsidv[0] = fsid_num;
>>   		break;
>>   	case FSID_MAJOR_MINOR:
>>   		fsidv[0] = (__force __u32)htonl(MAJOR(dev));
>> @@ -260,9 +257,10 @@ static inline bool fh_match(const struct knfsd_fh *fh1,
>>   static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
>>   				 const struct knfsd_fh *fh2)
>>   {
>> -	if (fh1->fh_fsid_type != fh2->fh_fsid_type)
>> +	if (fh1->fh_raw[FH_FSID_TYPE] != fh2->fh_raw[FH_FSID_TYPE])
>>   		return false;
>> -	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
>> +	if (memcmp(fh1->fh_raw + FH_FSID, fh2->fh_raw + FH_FSID,
>> +			key_len(fh1->fh_raw[FH_FSID_TYPE])) != 0)
>>   		return false;
>>   	return true;
>>   }
> 
> 

-Gustavo


