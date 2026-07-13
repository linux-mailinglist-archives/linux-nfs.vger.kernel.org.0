Return-Path: <linux-nfs+bounces-23302-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N+4fHNntVGqZhQAAu9opvQ
	(envelope-from <linux-nfs+bounces-23302-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 15:53:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2F74BEAE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 15:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ob8S2rHj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23302-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23302-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03F8D301BA59
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3054417365;
	Mon, 13 Jul 2026 13:39:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58325429827
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 13:39:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949946; cv=none; b=SiAmDPVfZTragIxuRBr6ysitGTOu2SCW8a7wwtXp5iuiX1PbL71BFLe8w6fFKxs83u9+IOyXM2J9fuHONBu0LD2VN0B6aPrTY0XMYSpRBEd7tKtHZKDEpjHPJSAJ9HAVd5mAcLLOux/cIbmvRHGnSUQsKbHUgAMmwryFizYypeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949946; c=relaxed/simple;
	bh=2sgOlwvRv/MQJRUiwVJmWUeDpJIWizdCGZuje/9WXkY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Vm54PculqTIwVfSuaxdByliLtE/h7AFT2uDxnR+ZAXIp5Mw49audIuiPyXydXiKJAMe83lZMhFzfY8n2c7+JoTA2X+tCAUFk2sD+JPy5ita6Lh8y3t81NtWM/FdlhN7w+8CrCX3/dQx2hp7AlC08BtERjtVdkizl9ptY/OHRJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob8S2rHj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96291F000E9
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949945;
	bh=ghniOw3xMPKLO/Ihucn2Je0Tn6O3xd8KH+NUWWGF04Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ob8S2rHjaP60oh4fvRO+qH+QEI4xa0yj/utvgVd5OkzYDm8SBU2A3gRdeLRT361q1
	 gF4P3Mky7DwGHlBhcOihA782wAgUn4SbAFGwwZRiXu/5cd72NF9+mqh2KVjvTz65s+
	 hRPyrVovAuExOZvZZ6ua57ljvX0w4TIi4n5C8Y87zP/tGYnU8d/KwaJnMvMb7IK0gi
	 eRrROSCOi3OCD0kYoa8d+lxja0fJHcKfyPBQ8M1Zn7YNkqrCWAzDloBjSousnDrhks
	 v0ehunnzwpWD1pQC7OSa+WwOsiNN4cssKyOBA9RBJvjViyIoQLvbHnBJbj57yhPa1s
	 LSOpU984UxqaA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E18BDF401F2;
	Mon, 13 Jul 2026 09:39:03 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jul 2026 09:39:03 -0400
X-ME-Sender: <xms:d-pUahwTP9WEnsaS5ShlQFaeDF1b2JBgU8JxCflIgW49qIamSZQrtg>
    <xme:d-pUasEeZTjt1Ixvz-qIGLKi38HIksgBYgMElYqAwXZMRb1lez1Ajtr-FcRM862TM
    alQe2FqTZI6rT_6FsgYpRg5SRbEm9hhiOjfCOkZNmxFbM93li8JexwG>
X-ME-Proxy-Cause: dmFkZTFMkrdOQ4BP2dl3r7z3NsEKJgXp6wyN7SiqzLlSsJB08Q/2Z9zGzZ/w0tm2HQuH/q
    vTqqt74u2E7oOH3KeiHCCXm1+DXAmH5IE3p2FI3jb86Y7EaiR8coP+JzjdXXEbqr/gQQMv
    n1I0YxnGRN2f+VfRvG37x0wkhmFxsM8wGQBObPr+XeVmBUiGl8SUAvRq4bMFbWLYn+EJAw
    BEQytG4zdMEZrNBcLnMaNhU0/zd++DSN005y1cvSirsIp4h03eVLI0kHn/7//a8LB0+BxI
    PnLNFVTBlU3FEX7iArp0vFJhU9AFhrjyJUJUxXDsMuF9OzIqWnPeFxh5gA4K8p9au8sVNe
    LKw0JQTRgUJD7ggiIEiJbuYvGYAEexIFwfrfH+k8H4J5FPcVk9rSMMY32knNm2X2xZUnw4
    EY4ZW1Iyi5TALTn/5msnd0uS8msV589kP2q9dwfXxEt0uJz7WdQ7l9tqMDqqC5spgpz/NR
    G/xQ/zEExiZQhXQDvf8x6hefIvfMi2T6QJ2C49Y3ETBGDUpJ2F/vJoF0NWMP8Nf9imb+NK
    VBScvSMEzircb0FnlEfkWd9ZNYJe4UE9vQMPnWjzvilbDcgiUaNLL6gAsHzknqAw6FZQ9d
    bElMkRs8BbJe4Gg3KSLiqDpie3AkQ2AUqdz96StOAW054mZ1wJMmEJylVMLw
X-ME-Proxy: <xmx:d-pUakrOJajASNaTUPtdsAIme7I5KewD6yg6RhTeoX383YVKDZPpqw>
    <xmx:d-pUarW_VnbX0iH29sDyVlM9GpY101-YIQ6hkdkchnTKWDwHgHCTJw>
    <xmx:d-pUanYSvUs7Y6plEE0BUViJ8CzwaKIB70KLqk07j9qPEZUT2joI4A>
    <xmx:d-pUagdALMkZwpKNyFKv-QNdcoDhQSb7GUXI_yFzPhxUb5yoPP6-rQ>
    <xmx:d-pUap3oq_X7P7_5Y2_WXGwXEpi7kxEEqedhEo3lMdAnVIu6RJkVg2M9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0F387811B3; Mon, 13 Jul 2026 09:39:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aie7gni1BOas
Date: Mon, 13 Jul 2026 09:38:43 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Message-Id: <2cf15b2e-639c-400f-9a60-7bb030c97762@app.fastmail.com>
In-Reply-To: <20260713062219.6399-3-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
 <20260713062219.6399-3-neilb@ownmail.net>
Subject: Re: [PATCH v3 02/17] nfsd: correctly handle CREATE of mounted-on files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23302-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AB2F74BEAE

Hi Neil-

On Mon, Jul 13, 2026, at 2:15 AM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>
> Linux allows a file (non-directory) to be mounted on a file.  nfsd
> mostly supports this if the crossmnt option is in effect.  However if
> CREATE is used on an existing mounted-on file, the filehandle for the
> underlying file is returns.  The client will then continue to use that
> filehandle.
>
> So
>   cat /mnt/file
> will show the contents of the mounted file as expected, but if
> the dcache is flushed with "drop_caches" or similar, then
>   >> /mnt/file
>   cat /mnt/file
> will show the mounted-on file.
>
> For exclusive or checked creates this is not a problem as the creation
> will fail no matter which file is seen. For unchecked creates we need to
> see if the name is in the dcache, and if it is mounted.  If so, we
> simply provide that filehandle, possibly truncating.
>
> Signed-off-by: NeilBrown <neil@brown.name>

I didn't see issues in the other patches in this series, but this
new one does have some correctness issues. This one doesn't build
here with CONFIG_NFSD_V2=y, and the NFSv2 and NFSv3 create paths
have some refcount and behavior problems. The NFSv4 path looks
good.

Big picture: the three create paths now handle an existing
mounted-on file three different ways. v4 sets op_truncate for
size-zero truncation only, v3 applies the full client iattr, and
v2 applies nothing.  The v4 behavior is the one I prefer, so
bring v2 and v3 into line with it.

Specifics below.


> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index bbaef884f893..20eaf56fa9e7 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -303,6 +303,34 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct 
> svc_fh *fhp,
>  	parent = fhp->fh_dentry;
>  	inode = d_inode(parent);
> 
> +	if (argp->createmode == NFS3_CREATE_UNCHECKED) {
> +		/*
> +		 * If name is already in dcache we need to check for mountpoints
> +		 */
> +		child = try_lookup_noperm(&QSTR_LEN(argp->name,
> +						    argp->len),
> +					  parent);
> +		if (child && !IS_ERR(child) && d_is_reg(child) &&
> +		    unlikely(nfsd_mountpoint(child, fhp->fh_export))) {
> +			struct svc_export *exp = exp_get(fhp->fh_export);
> +			if (nfsd_cross_mnt(rqstp, &child, &exp) == 0) {
> +				status = check_nfsd_access(exp, rqstp, false);
> +				if (status == nfs_ok)
> +					status = fh_compose(resfhp, exp,
> +							    child, fhp);
> +				if (status == nfs_ok)
> +					status = nfsd_create_setattr(
> +						rqstp, fhp, resfhp, &attrs);
> +				dput(child);
> +				exp_put(exp);
> +				return status;
> +			}
> +			exp_put(exp);
> +		}
> +		if (!IS_ERR(child))
> +			dput(child);
> +	}
> +
>  	host_err = fh_want_write(fhp);
>  	if (host_err)
>  		return nfserrno(host_err);

The ordinary UNCHECKED path masks iap->ia_valid to ATTR_SIZE before
calling nfsd_create_setattr(). This branch passes the full client
iattr, so it applies atime/mtime to the existing mounted-on file
that the ordinary create path drops. Mask to ATTR_SIZE here too.


> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index f60043632575..549eed8f2c19 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -302,11 +302,34 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	if (resp->status != nfs_ok)
>  		goto done; /* must fh_put dirfhp even on error */
> 
> +	fh_init(newfhp, NFS_FHSIZE);
> +
>  	/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
> 
>  	resp->status = nfserr_exist;
>  	if (name_is_dot_dotdot(argp->name, argp->len))
>  		goto done;
> +
> +	/*
> +	 * If name is already in dcache we need to check for mountpoints
> +	 */
> +	dchild = try_lookup_noperm(&QSTR_LEN(argp->name, argp->len),
> +				   dirfhp->fh_export);
> +	if (dchild && !IS_ERR(dchild) && d_is_reg(child) &&
> +	    unlikely(nfsd_mountpoint(dchild, fhp->fh_export))) {

This hunk does not compile with CONFIG_NFSD_V2=y.


> +		struct svc_export *exp = fhp->fh_export;
> +		if (nfsd_cross_mnt(rqstp, &dchild, &exp) == 0 &&
> +		    d_isreg(dchild)) {

nfsd_cross_mnt() drops a reference on the export it is given and
returns referenced replacements in dchild and exp. This branch
hands it the filehandle's borrowed fh_export with no exp_get(),
so a successful crossing underflows the export refcount. It then
jumps to done without releasing either replacement, leaking dchild
and exp. The v3 and v4 hunks get this right: exp_get() first,
dput(child) and exp_put(exp) after.


> +			resp->status = check_nfsd_access(exp, rqstp, false);
> +			if (resp->status == nfs_ok)
> +				resp->status = fh_compose(newfhp, dirfhp->fh_export,
> +							  dchild, dirfhp);

After the crossing, dchild is on the mounted filesystem, which exp
describes, not dirfhp->fh_export. Thus fh_compose() must use exp
here.


> +			goto done;

The normal v2 path truncates an existing regular file: it masks to
ATTR_SIZE and calls nfsd_setattr(). This branch returns without
truncating, so an UNCHECKED create with size zero leaves the
mounted-on file's contents intact.


Lastly, should we consider this patch for backporting to LTS? If
so, I'm guessing the issues it fixes were introduced at different
points in the commit history, so this patch would have to be split
accordingly. (If no backporting is necessary, then it can remain
as a single patch).


-- 
Chuck Lever

