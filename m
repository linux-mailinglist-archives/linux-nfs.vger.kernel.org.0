Return-Path: <linux-nfs+bounces-22529-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J7l8DMRLLGrzOwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22529-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:11:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D567B8EA
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:11:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZzvCtgqA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22529-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22529-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA68330B32DD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4837BE87;
	Fri, 12 Jun 2026 18:09:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAB37B012
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 18:09:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287746; cv=none; b=ndyiDZyaUNLRj/STOB7+cxvJ3y6AciiWr5VOWtoEevWn3sY3oK2saRK9O/Sjz6zgSCkgI56pumS/jK8qwvz/4x5tKYG1nA+oWjaE0tAdBwHCdXVSoTYgU5Q4Y9l/Xb2xT03zhz2RaDH9Ncd7gLVBPmoNxsxPhKwOQFhoitUt5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287746; c=relaxed/simple;
	bh=XdFHiaYZarqAKmkJa+iYPf/j0N0krP2g2DDOH6NN7Ps=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bqSt7AlP9LMDrqLnRAsdSTcF6+ZMSZHCeMDynoNAffL2m7c4aSNzq4JCObg58B7yG9sOoB2iZMa8HHekyojnMkZn4czojbJLJ8+mwjStYiOy5aGcU9wvmwdnmRXlpArGhPRujwwwYbDAQVf+s9Fh6yW5LQnGXzmzG//5GdqvX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzvCtgqA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C4E1F000E9;
	Fri, 12 Jun 2026 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287745;
	bh=zvTL2w1yOSiSnSotjK2o1/0Kkp/uJrKD7/9wya/Zpzw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZzvCtgqAbzBY+ouZlRzFOTfn4ei0rcj3oJ1jhfacHBB+CE835OXU9wE6Ns4JUdLDs
	 Ju1LwhrjdNGczdq+dBPGYt2rqlTpsE7FxYs7zDAAl8kqXwZE2EILCNEm/y2iqH9CV6
	 gNzrph5iyCHrov9fhCypKKKkA36LF241H6ZEgcSAahy9C6MJfqK8E4YdQtt0okDvBV
	 afsGGxfDLXtF5t/Pm1dE43YR3IheRZ4jnhu5hPielErRv/2GgIXxru30KCdG/MX/GA
	 luTQpKP+p8Z4dfORWfKYl6GAZSuz26IauUxPcoQ5l8h9i0SdwW240jO/DsaUafC/2Q
	 lGZ0emO7nlBVg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BBE0CF4006B;
	Fri, 12 Jun 2026 14:09:03 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 14:09:03 -0400
X-ME-Sender: <xms:P0ssajM7xwxr9lfeeUnAzPpAslmcmO96l2J2fsQMyFpembZ5HcYKvw>
    <xme:P0ssaozalhhPDSg3qxhNfCf0g2hu2y97QzmoJX0qmXiMDtkOdaTXk7T3xteV5n9k2
    XEbdajrKMcFDVtlQlfyHxuJcHgISxZg78SUovOLN-HtpsMqkQpxbgM>
X-ME-Proxy-Cause: dmFkZTEQVELxuIX5+6rKVVQ926Wl5DU2GmSvdAPFG/0Ke+QSAVWRvCR1IXSq1KOzPMNRMb
    VFMkRhugKoRNkb6sMdPc5nqoFzXrGDRQoGJmktwH0eB8gaE4e6Jaaxh7gf4JGEpNwHfq2v
    Ge4thWzB9KFn20yURN++icHqDtZ+TRmFIB991ERKcNJd4BQvyW+SDZZ85qmnq/kGRCjqY8
    Z336i0BsnjMb27pibMWFB11HQaO/h4mPZYvLWTGgM+NJz955s0GywV6O2KBwnGEUzAOCx3
    fZzxSN6LgHJfp/tCw7y1PEFhPgBlTnZoFFeYFC/UwigEyQFq/Xd3ZcxZEmvDpGKcdn2Zjw
    4OXmsbOa0ZPvp8iNCmn40/gDLJigkZC0gJRKLGdFnoeulDTkjtkRI+WFJeHa4sdCySk3rf
    f4hPCbHGbp9E30wbH6ny/uLVo82qHh8m/NF3Q18q04gTiRlahWXw9FjY495Hgg7aqxPPRL
    fhx6TZKlt9hduP7DhU6SZP91P9xPFWcdA4MAQagYpTHsPOx2NDR+GW7ez6UsySrT8VSr60
    Wlh0oYychgOjCOd4nuUo5uX9i5E5DVdYMDy66Kh1MeNVkkQacmV6O3sJJWT5dp9UnXGZP4
    Ghq9yMTvUxWds+SuTAE47uBdegaF9VewcXWRH5n2M1Az095plC8GlhNiPFIA
X-ME-Proxy: <xmx:P0ssaiELV2n7UuMpc_RkZJVK7EDNV-3GXMCgVM7gaqEmNmocrfLP4w>
    <xmx:P0ssaoM6TWs4A8abNfoL9TaFmP2vCy-E9WshNj7V9m7UE5ophikqOQ>
    <xmx:P0ssakvkg9DXkdOiLo-ZCzR-W5HgcRVsgsbrnFRsiNYk4b7tjHwX6A>
    <xmx:P0ssatXkaqKvdEwQwqVcizlNQX8o_uJo72orEajN2cGR1Q3tVb4lDA>
    <xmx:P0ssarSziuSJJ4YFGRSn3K1wxYMQlmO4zmlwEEu2FtjwHbzcfgxoLyz5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 91C83780070; Fri, 12 Jun 2026 14:09:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AcMjPYD26Dvc
Date: Fri, 12 Jun 2026 14:08:42 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <bb6e580b-5deb-4731-afda-07c23e572b4e@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-17-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-17-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 17/20] nfsd: add the filehandle to returned attributes in
 CB_NOTIFY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22529-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C57D567B8EA



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> nfsd's usual fh_compose routine requires a svc_export and fills out a
> svc_fh. In the context of a CB_NOTIFY there is no such export to
> consult.
>
> Add a new routine that composes a filehandle with only a parent
> filehandle and nfs4_file. Use that to fill out the fhandle field in the
> nfsd4_fattr_args.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4xdr.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7b19248b1503..15ccd54ffdb6 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4197,6 +4197,39 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, 
> struct xdr_stream *xdr,
>  	goto out;
>  }
> 
> +static bool
> +setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
> +		     struct nfsd_file *nf, struct nfsd4_fattr_args *args)
> +{
> +	int fileid_type, fsid_len, maxsize, flags = 0;
> +	struct knfsd_fh *fhp = &args->fhandle;
> +	struct inode *inode = d_inode(dentry);
> +	struct inode *parent = NULL;
> +	struct fid *fid;
> +
> +	fsid_len = key_len(fi->fi_fhandle.fh_fsid_type);
> +	fhp->fh_size = 4 + fsid_len;
> +
> +	/* Copy first 4 bytes + fsid */
> +	memcpy(&fhp->fh_raw, &fi->fi_fhandle.fh_raw, fhp->fh_size);
> +
> +	fid = (struct fid *)(fh_fsid(fhp) + fsid_len/4);
> +	maxsize = (NFS4_FHSIZE - fhp->fh_size)/4;
> +
> +	if (fi->fi_connectable && !S_ISDIR(inode->i_mode)) {
> +		parent = d_inode(nf->nf_file->f_path.dentry);
> +		flags = EXPORT_FH_CONNECTABLE;
> +	}
> +
> +	fileid_type = exportfs_encode_inode_fh(inode, fid, &maxsize, parent, 
> flags);
> +	if (fileid_type < 0 || fileid_type == FILEID_INVALID)
> +		return false;
> +
> +	fhp->fh_fileid_type = fileid_type;
> +	fhp->fh_size += maxsize * 4;
> +	return true;
> +}
> +
>  #define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
>  				      STATX_BTIME	  | \
>  				      STATX_CHANGE_COOKIE)
> @@ -4206,6 +4239,7 @@ nfsd4_setup_notify_entry4(struct notify_entry4 
> *ne, struct xdr_stream *xdr,
>  			  struct dentry *dentry, struct nfs4_delegation *dp,
>  			  struct nfsd_file *nf, char *name, u32 namelen)
>  {
> +	struct nfs4_file *fi = dp->dl_stid.sc_file;
>  	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
>  			      .dentry = dentry };
>  	struct nfsd4_fattr_args args = { };
> @@ -4244,6 +4278,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 
> *ne, struct xdr_stream *xdr,
>  		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
>  	attrmask[2] = 0;
> 
> +	if (setup_notify_fhandle(dentry, fi, nf, &args))
> +		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
> +
>  	if (args.stat.result_mask & STATX_BTIME)
>  		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
> 

Codex flagged setup_notify_fhandle() for constructing a child FILEHANDLE
attribute without calling fh_append_mac(): for exports with sign_fh,
fh_compose() appends a MAC, and nfsd_set_fh_dentry() rejects every
non-root signed-export handle whose MAC is absent or mismatched, so a
client using the CB_NOTIFY filehandle gets a stale/bad handle. It
recommends signing the constructed handle or suppressing the attribute
when the export requires signed filehandles.

A client that does not receive the FH falls back to a LOOKUP, so
suppression degrades gracefully.

-- 
Chuck Lever

