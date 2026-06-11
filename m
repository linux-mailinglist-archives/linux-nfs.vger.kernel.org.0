Return-Path: <linux-nfs+bounces-22518-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8tsZGtopK2q+3QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22518-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 23:34:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060567573F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 23:34:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JpGgt4YU;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22518-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22518-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473E1319F971
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F6378D63;
	Thu, 11 Jun 2026 21:33:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA023803DA
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 21:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213627; cv=none; b=KCrXGE/QVo912eh7nv/vJSOcwKR2vFMB9Yd6fbf2ju5fSVdUr/jATVupFhf2JLg1My3/vF9t4yYrA7fmMWLF6iuGfscFsGkMHptus7gcP6DKSj/OeQbMozA9XzNkPoctoc0/DGLIPE8k4DVSQ3SmuHYtU4vRT7Co1oClkZ4dQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213627; c=relaxed/simple;
	bh=K8lIvci/F8SDAKMdJB7BnX6zqQWLsHApGUSZHS5jaIw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YFowHU2aA8lSqt795z1rljdMjAo4fTYj5L0TJaj8x4bJyhE5HFhX7iJ+ewFFUsxPPXow70Twwb90S176k/ixdJR4OO3vx9vJV6QwIfF0TvIZnGpverwyCAR7OSfF1lg0Ff7ZzpzVY09pUUx2pCyVHLDBxBdlvBPZ8026nggu1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpGgt4YU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F1C1F00A3A;
	Thu, 11 Jun 2026 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781213625;
	bh=paONQ3+/JxsYzY9c7eX9yCDzQxkvA7sdMubyl11cOKY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JpGgt4YUfW02ykAS3pLRQ8YsA82uaaXCsFgxcG2BS/MEN4L+T2mq8/JiP/osJ/1we
	 yDsAYSM4y7jx6Hfz3gj2XiQUrSvP5TUCdfC0K8A8n8Up8PN7+wfzZUqlEIMMB8Fzd0
	 37FpUXKUKlkBpPGZKGqJmakPr3V2E8x4fZxJMFJdE8nrmoepzjGPvYnQvzI+kod0Bt
	 p6CvQbJhWC90OCUyLWDNqe7X6KPv2GaKcme0lJwAh4XPfbAL2kl+w5yvYxgd+0CpRA
	 +FNDuX/j7xGXzRvallCFE24SQfPQoR8wr2mfna6l07t0QT2SJQBCJVYw7viBQLl1VT
	 PLVguEx8rd9Xw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 34A0BF4007A;
	Thu, 11 Jun 2026 17:33:44 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 17:33:44 -0400
X-ME-Sender: <xms:uCkraop8e50CHXyzlnyBtJ1fua1WU7GpxyKbJsnbeC3QYh9SZfiC3Q>
    <xme:uCkrapfWPlYr5B9LnW6D8BUJ99Yq07sTA-QW52M60siDy-ZsrFwIl5VadiJyZHw2B
    UASfT2LRjqkIu4aklVrCHeChcxyMcg_hE4NHA9QdI0fSccVlvsNnn18>
X-ME-Proxy-Cause: dmFkZTE2/sgOU1xp1hUhRw/3940WN0vNnwsUttBVn00lxnxCZPmCdMHTTNpyDYnGpSuBhU
    i+yiKJREczGwWisOS51wW2DNa9R/moquxJOWf2Fdvrds2fAGH2UXGURt7EvpJGkCBijaDC
    FxfUZ76yX1GFxEOht9f0rKtZsTdGbUHv3KiGJhyTw0c4/Zv5ZcubcQ8xuBe1u92jvSyylC
    mKxZO0wxPYJ9/jIDjhc85sT/fWIY8qmxMXo0IDA5jjQ1PZSU67jVspO4BBv/LROS6aoL/E
    QLFId6Ap7OwrQP7NLZ/LZnb2LBa50QPQmRHHJgWyPEHFySRlKabeQVgVUiOOnZBhaZ/7DP
    SeY8kc+gSy7tNWwubBk+KhgE8mlf9vbbCDe+G/Nnf5A3IBGJH0mkQ3j0ZEe0E2BMxZEdFE
    lO/vqsu7sCp1ivDxEagEw38HFR/BwKnWaPwnknpFqgSn9ZoQi018zv8l6/a4TevjqGOF10
    hm7PuEPl7fnSMnDoJCbHjf9/cFgwy1axBZAF7wPwjcNKJDsNKe2NlHWDxjxHdJaEXqTB77
    /ToTHukBF+4ff0zFgQbH+hlGv3EK75JCAYmuQGN1C74iWCHD35SVCYiu77Q4Uq6rundWO1
    GJJb4NSsHMw77ItEcFtNsGbpb9cQdOCyfy4jj21bb+bFHyjgahw1sYxVQ9kA
X-ME-Proxy: <xmx:uCkrauCuR5XiDSwxSRPKzzti0wu-b0QMgV7RZFDq1ZEfuujuxt2Dxg>
    <xmx:uCkrataM9OndfMGmz34gknkaw9xnySpfkdlppc4hMLgy3b7Ih13fVw>
    <xmx:uCkraqKDPPAfaYJU0Ld_RKcv8tH1z6jbOPmoGTnUdAXhRuG5Dn0Vbw>
    <xmx:uCkrauDmYlnQUa49_PNPUPaglJGYusoH4Dh4D-SbnkxHEi60_qT7yw>
    <xmx:uCkramN0HQrHY7RrB1cbShAb6ikZEZtgLnsM87LC2Zg0TaKhWz19mBXp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06E44780070; Thu, 11 Jun 2026 17:33:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A11Uoc6bJND3
Date: Thu, 11 Jun 2026 17:33:23 -0400
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
Message-Id: <9119f5c0-cf25-4f30-bad2-b928a2db239d@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-2-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-2-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 02/20] nfsd: add protocol support for CB_NOTIFY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22518-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seq.id:url,vger.kernel.org:from_smtp,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0060567573F


On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:

> diff --git a/Documentation/sunrpc/xdr/nfs4_1.x 
> b/Documentation/sunrpc/xdr/nfs4_1.x
> index 5b45547b2ebc..632f5b579c39 100644
> --- a/Documentation/sunrpc/xdr/nfs4_1.x
> +++ b/Documentation/sunrpc/xdr/nfs4_1.x
> @@ -45,19 +45,165 @@ pragma header nfs4;
>  /*
>   * Basic typedefs for RFC 1832 data type definitions
>   */
> -typedef hyper		int64_t;
> -typedef unsigned int	uint32_t;
> +typedef int                  int32_t;
> +typedef unsigned int         uint32_t;
> +typedef hyper                int64_t;
> +typedef unsigned hyper       uint64_t;
> +
> +const NFS4_VERIFIER_SIZE        = 8;
> +const NFS4_FHSIZE               = 128;
> +
> +enum nfsstat4 {
> + NFS4_OK                = 0,    /* everything is okay      */
> + NFS4ERR_PERM           = 1,    /* caller not privileged   */
> + NFS4ERR_NOENT          = 2,    /* no such file/directory  */
> + NFS4ERR_IO             = 5,    /* hard I/O error          */
> + NFS4ERR_NXIO           = 6,    /* no such device          */
> + NFS4ERR_ACCESS         = 13,   /* access denied           */
> + NFS4ERR_EXIST          = 17,   /* file already exists     */
> + NFS4ERR_XDEV           = 18,   /* different filesystems   */
> +
> + /*
> +  * Please do not allocate value 19; it was used in NFSv3
> +  * and we do not want a value in NFSv3 to have a different
> +  * meaning in NFSv4.x.
> +  */
> +
> + NFS4ERR_NOTDIR         = 20,   /* should be a directory   */
> + NFS4ERR_ISDIR          = 21,   /* should not be directory */
> + NFS4ERR_INVAL          = 22,   /* invalid argument        */
> + NFS4ERR_FBIG           = 27,   /* file exceeds server max */
> + NFS4ERR_NOSPC          = 28,   /* no space on filesystem  */
> + NFS4ERR_ROFS           = 30,   /* read-only filesystem    */
> + NFS4ERR_MLINK          = 31,   /* too many hard links     */
> + NFS4ERR_NAMETOOLONG    = 63,   /* name exceeds server max */
> + NFS4ERR_NOTEMPTY       = 66,   /* directory not empty     */
> + NFS4ERR_DQUOT          = 69,   /* hard quota limit reached*/
> + NFS4ERR_STALE          = 70,   /* file no longer exists   */
> + NFS4ERR_BADHANDLE      = 10001,/* Illegal filehandle      */
> + NFS4ERR_BAD_COOKIE     = 10003,/* READDIR cookie is stale */
> + NFS4ERR_NOTSUPP        = 10004,/* operation not supported */
> + NFS4ERR_TOOSMALL       = 10005,/* response limit exceeded */
> + NFS4ERR_SERVERFAULT    = 10006,/* undefined server error  */
> + NFS4ERR_BADTYPE        = 10007,/* type invalid for CREATE */
> + NFS4ERR_DELAY          = 10008,/* file "busy" - retry     */
> + NFS4ERR_SAME           = 10009,/* nverify says attrs same */
> + NFS4ERR_DENIED         = 10010,/* lock unavailable        */
> + NFS4ERR_EXPIRED        = 10011,/* lock lease expired      */
> + NFS4ERR_LOCKED         = 10012,/* I/O failed due to lock  */
> + NFS4ERR_GRACE          = 10013,/* in grace period         */
> + NFS4ERR_FHEXPIRED      = 10014,/* filehandle expired      */
> + NFS4ERR_SHARE_DENIED   = 10015,/* share reserve denied    */
> + NFS4ERR_WRONGSEC       = 10016,/* wrong security flavor   */
> + NFS4ERR_CLID_INUSE     = 10017,/* clientid in use         */
> +
> + /* NFS4ERR_RESOURCE is not a valid error in NFSv4.1 */
> + NFS4ERR_RESOURCE       = 10018,/* resource exhaustion     */
> +
> + NFS4ERR_MOVED          = 10019,/* filesystem relocated    */
> + NFS4ERR_NOFILEHANDLE   = 10020,/* current FH is not set   */
> + NFS4ERR_MINOR_VERS_MISMATCH= 10021,/* minor vers not supp */
> + NFS4ERR_STALE_CLIENTID = 10022,/* server has rebooted     */
> + NFS4ERR_STALE_STATEID  = 10023,/* server has rebooted     */
> + NFS4ERR_OLD_STATEID    = 10024,/* state is out of sync    */
> + NFS4ERR_BAD_STATEID    = 10025,/* incorrect stateid       */
> + NFS4ERR_BAD_SEQID      = 10026,/* request is out of seq.  */
> + NFS4ERR_NOT_SAME       = 10027,/* verify - attrs not same */
> + NFS4ERR_LOCK_RANGE     = 10028,/* overlapping lock range  */
> + NFS4ERR_SYMLINK        = 10029,/* should be file/directory*/
> + NFS4ERR_RESTOREFH      = 10030,/* no saved filehandle     */
> + NFS4ERR_LEASE_MOVED    = 10031,/* some filesystem moved   */
> + NFS4ERR_ATTRNOTSUPP    = 10032,/* recommended attr not sup*/
> + NFS4ERR_NO_GRACE       = 10033,/* reclaim outside of grace*/
> + NFS4ERR_RECLAIM_BAD    = 10034,/* reclaim error at server */
> + NFS4ERR_RECLAIM_CONFLICT= 10035,/* conflict on reclaim    */
> + NFS4ERR_BADXDR         = 10036,/* XDR decode failed       */
> + NFS4ERR_LOCKS_HELD     = 10037,/* file locks held at CLOSE*/
> + NFS4ERR_OPENMODE       = 10038,/* conflict in OPEN and I/O*/
> + NFS4ERR_BADOWNER       = 10039,/* owner translation bad   */
> + NFS4ERR_BADCHAR        = 10040,/* utf-8 char not supported*/
> + NFS4ERR_BADNAME        = 10041,/* name not supported      */
> + NFS4ERR_BAD_RANGE      = 10042,/* lock range not supported*/
> + NFS4ERR_LOCK_NOTSUPP   = 10043,/* no atomic up/downgrade  */
> + NFS4ERR_OP_ILLEGAL     = 10044,/* undefined operation     */
> + NFS4ERR_DEADLOCK       = 10045,/* file locking deadlock   */
> + NFS4ERR_FILE_OPEN      = 10046,/* open file blocks op.    */
> + NFS4ERR_ADMIN_REVOKED  = 10047,/* lockowner state revoked */
> + NFS4ERR_CB_PATH_DOWN   = 10048,/* callback path down      */
> +
> + /* NFSv4.1 errors start here. */
> +
> + NFS4ERR_BADIOMODE      = 10049,
> + NFS4ERR_BADLAYOUT      = 10050,
> + NFS4ERR_BAD_SESSION_DIGEST = 10051,
> + NFS4ERR_BADSESSION     = 10052,
> + NFS4ERR_BADSLOT        = 10053,
> + NFS4ERR_COMPLETE_ALREADY = 10054,
> + NFS4ERR_CONN_NOT_BOUND_TO_SESSION = 10055,
> + NFS4ERR_DELEG_ALREADY_WANTED = 10056,
> + NFS4ERR_BACK_CHAN_BUSY = 10057,/*backchan reqs outstanding*/
> + NFS4ERR_LAYOUTTRYLATER = 10058,
> + NFS4ERR_LAYOUTUNAVAILABLE = 10059,
> + NFS4ERR_NOMATCHING_LAYOUT = 10060,
> + NFS4ERR_RECALLCONFLICT = 10061,
> + NFS4ERR_UNKNOWN_LAYOUTTYPE = 10062,
> + NFS4ERR_SEQ_MISORDERED = 10063,/* unexpected seq.ID in req*/
> + NFS4ERR_SEQUENCE_POS   = 10064,/* [CB_]SEQ. op not 1st op */
> + NFS4ERR_REQ_TOO_BIG    = 10065,/* request too big         */
> + NFS4ERR_REP_TOO_BIG    = 10066,/* reply too big           */
> + NFS4ERR_REP_TOO_BIG_TO_CACHE =10067,/* rep. not all cached*/
> + NFS4ERR_RETRY_UNCACHED_REP =10068,/* retry & rep. uncached*/
> + NFS4ERR_UNSAFE_COMPOUND =10069,/* retry/recovery too hard */
> + NFS4ERR_TOO_MANY_OPS   = 10070,/*too many ops in [CB_]COMP*/
> + NFS4ERR_OP_NOT_IN_SESSION =10071,/* op needs [CB_]SEQ. op */
> + NFS4ERR_HASH_ALG_UNSUPP = 10072, /* hash alg. not supp.   */
> +                                /* Error 10073 is unused.  */
> + NFS4ERR_CLIENTID_BUSY  = 10074,/* clientid has state      */
> + NFS4ERR_PNFS_IO_HOLE   = 10075,/* IO to _SPARSE file hole */
> + NFS4ERR_SEQ_FALSE_RETRY= 10076,/* Retry != original req.  */
> + NFS4ERR_BAD_HIGH_SLOT  = 10077,/* req has bad highest_slot*/
> + NFS4ERR_DEADSESSION    = 10078,/*new req sent to dead sess*/
> + NFS4ERR_ENCR_ALG_UNSUPP= 10079,/* encr alg. not supp.     */
> + NFS4ERR_PNFS_NO_LAYOUT = 10080,/* I/O without a layout    */
> + NFS4ERR_NOT_ONLY_OP    = 10081,/* addl ops not allowed    */
> + NFS4ERR_WRONG_CRED     = 10082,/* op done by wrong cred   */
> + NFS4ERR_WRONG_TYPE     = 10083,/* op on wrong type object */
> + NFS4ERR_DIRDELEG_UNAVAIL=10084,/* delegation not avail.   */
> + NFS4ERR_REJECT_DELEG   = 10085,/* cb rejected delegation  */
> + NFS4ERR_RETURNCONFLICT = 10086,/* layout get before return*/
> + NFS4ERR_DELEG_REVOKED  = 10087, /* deleg./layout revoked   */
> + NFS4ERR_PARTNER_NOTSUPP = 10088,
> + NFS4ERR_PARTNER_NO_AUTH = 10089,
> + NFS4ERR_UNION_NOTSUPP = 10090,
> + NFS4ERR_OFFLOAD_DENIED = 10091,
> + NFS4ERR_WRONG_LFS = 10092,
> + NFS4ERR_BADLABEL = 10093,
> + NFS4ERR_OFFLOAD_NO_REQS = 10094,
> + NFS4ERR_NOXATTR = 10095,
> + NFS4ERR_XATTR2BIG = 10096,
> +
> + /* always set this to one more than the last one in the enum */
> + NFS4ERR_FIRST_FREE = 10097
> +};

This value can be leaked onto the wire. The basic enum encoder
checks that these values are part of the .x before sticking
them on the wire.

Please keep the .x document aligned with the specification. If
you need a "maximum value" symbolic constant, please define it
in one of the hand-rolled headers. (I guess this one was copied
over from the existing hand-rolled NFS4ERR definitions).

I see that NFS4ERR_FIRST_FREE is used to determine the numeric
value for NFSERR_EOF.

fs/nfsd/nfs3xdr.c:              if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
fs/nfsd/nfs4xdr.c:      return nfsd4_encode_bool(xdr, readdir->common.err == nfserr_eof);
fs/nfsd/nfsd.h: __be32                  err;    /* 0, nfserr, or nfserr_eof */
fs/nfsd/nfsd.h:#define  nfserr_eof              cpu_to_be32(NFSERR_EOF)
fs/nfsd/nfsxdr.c:               if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
fs/nfsd/vfs.c:          cdp->err = nfserr_eof; /* will be cleared on successful read */
fs/nfsd/vfs.c:  if (err == nfserr_eof || err == nfserr_toosmall)

A better interim approach might be to select an impossible value
for NFSERR_EOF, as is done for the internal NLM error status codes:

fs/lockd/lockd.h:#define nlm__int__drop_reply   cpu_to_be32(30000)
fs/lockd/lockd.h:#define nlm__int__deadlock     cpu_to_be32(30001)
fs/lockd/lockd.h:#define nlm__int__stale_fh     cpu_to_be32(30002)
fs/lockd/lockd.h:#define nlm__int__failed       cpu_to_be32(30003)


> @@ -245,3 +406,88 @@ const FATTR4_ACL_TRUEFORM	= 89;
>  const FATTR4_ACL_TRUEFORM_SCOPE	= 90;
>  const FATTR4_POSIX_DEFAULT_ACL	= 91;
>  const FATTR4_POSIX_ACCESS_ACL	= 92;
> +
> +/*
> + * Directory notification types.
> + */
> +enum notify_type4 {
> +        NOTIFY4_CHANGE_CHILD_ATTRS = 0,
> +        NOTIFY4_CHANGE_DIR_ATTRS = 1,
> +        NOTIFY4_REMOVE_ENTRY = 2,
> +        NOTIFY4_ADD_ENTRY = 3,
> +        NOTIFY4_RENAME_ENTRY = 4,
> +        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
> +};
> +
> +/* Changed entry information.  */
> +struct notify_entry4 {
> +        component4      ne_file;
> +        fattr4          ne_attrs;
> +};
> +
> +/* Previous entry information */
> +struct prev_entry4 {
> +        notify_entry4   pe_prev_entry;
> +        /* what READDIR returned for this entry */
> +        nfs_cookie4     pe_prev_entry_cookie;
> +};
> +
> +struct notify_remove4 {
> +        notify_entry4   nrm_old_entry;
> +        nfs_cookie4     nrm_old_entry_cookie;
> +};
> +pragma public notify_remove4;
> +
> +struct notify_add4 {
> +        /*
> +         * Information on object
> +         * possibly renamed over.
> +         */
> +        notify_remove4      nad_old_entry<1>;
> +        notify_entry4       nad_new_entry;
> +        /* what READDIR would have returned for this entry */
> +        nfs_cookie4         nad_new_entry_cookie<1>;
> +        prev_entry4         nad_prev_entry<1>;
> +        bool                nad_last_entry;
> +};
> +pragma public notify_add4;
> +
> +struct notify_attr4 {
> +        notify_entry4   na_changed_entry;
> +};
> +pragma public notify_attr4;
> +
> +struct notify_rename4 {
> +        notify_remove4  nrn_old_entry;
> +        notify_add4     nrn_new_entry;
> +};
> +pragma public notify_rename4;
> +
> +struct notify_verifier4 {
> +        verifier4       nv_old_cookieverf;
> +        verifier4       nv_new_cookieverf;
> +};
> +
> +/*
> + * Objects of type notify_<>4 and
> + * notify_device_<>4 are encoded in this.
> + */
> +typedef opaque notifylist4<>;
> +
> +struct notify4 {
> +        /* composed from notify_type4 or notify_deviceid_type4 */
> +        bitmap4         notify_mask;
> +        notifylist4     notify_vals;
> +};
> +
> +struct CB_NOTIFY4args {
> +        stateid4    cna_stateid;
> +        nfs_fh4     cna_fh;
> +        notify4     cna_changes<>;
> +};
> +pragma public CB_NOTIFY4args;
> +
> +struct CB_NOTIFY4res {
> +        nfsstat4    cnr_status;
> +};
> +pragma public CB_NOTIFY4res;

Let's add the "pragma public" directives in the patches where
they are first needed, instead of here. As subsequent patches
are modified, the need for these directives might vanish.


-- 
Chuck Lever

