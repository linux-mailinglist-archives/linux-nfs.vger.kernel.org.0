Return-Path: <linux-nfs+bounces-21272-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FFDISoL8mlXnAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21272-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 15:44:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 520864950C7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 483DD30164AD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C24014A1;
	Wed, 29 Apr 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPuXwIWy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A03EF64C
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470095; cv=none; b=c8wySEEZ4EyfabNdlWk9DF1eivn7jUXpCTP1IH6uUgYSs8K/BJlZqmxfQQwRQ8PMWZTPifKz/CqplZiIml8axkDVJPynt6HxLseqaduRqWbLw4o+/X/04SPKOZ7gryHqjU6p6ma1SWdgMVKw5wHgSwAmtbyNLUzy3SnrgjmTZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470095; c=relaxed/simple;
	bh=AbmPDiLMo35LZVw+xaDp8x+ViqIl5t2Bms1xbcVtE5U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CXvzoI2CWoF0PqdHpSJ1g8BhPzmOAlMZYbd4UraLZ6oEfpSs1vfmmtuEv/dG1POUN+XzAAdc5VKo/miNCR/IGf6NP6f5BFlkYSrUotw2OlgpZGweP8gt0TBILZWBnf4wX309A1XfqKCQ7B5ovg7hkvNeQ9vJHKsa4pAZp2MBpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPuXwIWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B836C2BCB8;
	Wed, 29 Apr 2026 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470094;
	bh=AbmPDiLMo35LZVw+xaDp8x+ViqIl5t2Bms1xbcVtE5U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kPuXwIWyV3rcevzEMHi7at0wpiA0+CKJYgaCBRhy5ADn94HzEt8iMqtJGukdWZooc
	 WMamYtKFznkJq3MF49FgtuyZ6XJAEt2mpplmUxhrORfqC7eyiZqf6gKWy7Pg5zzDU+
	 llWGlAspu5pjCn9GOvZchncPk9YOB7XPNAgxTLBhe6Vfh3EsUIb+ID72SqSkdSVDRP
	 EqMPiJwcF426/BSokxk119Zingj53lMZUxM+r2OiHlNHEfluCFYr8eyuQhPXjzfXpm
	 aK49VopzXnIpGqepYItBqbX9DpRtBGJcITTKUPra9mXjrt1Gbi89XRkmb/da8i3D62
	 NZPUd+N4jr8lA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 460EDF40068;
	Wed, 29 Apr 2026 09:41:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 29 Apr 2026 09:41:33 -0400
X-ME-Sender: <xms:jQryaSQHFzntyBx-jomblrJhtzbOen6R4iuCOpHPo4gRNj7tinAEDQ>
    <xme:jQryaSk296dZuhIQkQEK_f2EHNBkX-7riWofWTk0phchaKd_qiSHmKhkEBLEn8DYN
    RzhRn1CjoxbnJJ-CuJKnYNccFjRUAF0IuxJIZSZwqFQEHFhVLs1_vKH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epjeevhfduheeltedvjefhjeevgffhleegjeevvdfgudeuffefgedtjeeuhfeiudeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpe
    epkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    vdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghilhessghrohifnhdrnh
    grmhgvpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghi
    ohhsrdgtohhmpdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhho
    shhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegrnhhnrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhihhrrg
    hmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jQryaVDlYB1TdmPkCsoSJMtD1Ig_-AZ56-UySqiHekH40H-tO8fn3w>
    <xmx:jQryaVMeZOkGKSqz9lA7BTw-KSyhBXPKuzUADcnv-56s0PwVNstu2A>
    <xmx:jQryaUAsYj5qYDg8Vog6nLLy0ykeKPf5gOJIUECayWL1fUV4BEWXPg>
    <xmx:jQryaflM_WfAdEBfMGiT-NJ4_MKWpMtzj9f-vCyESEoteRVvmjCMwQ>
    <xmx:jQryaQrZ-cFoNbjEtfFW9cbVymZSHRFDPz8LkrLDkvlbMNV-i6QvRLaI>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 198F0780070; Wed, 29 Apr 2026 09:41:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJifn_5JDXrR
Date: Wed, 29 Apr 2026 09:41:12 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: "Calum Mackay" <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <d6e54da6-3f7f-4c56-b08a-5b14beecaa48@app.fastmail.com>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
Subject: Re: [PATCH v3 00/28] vfs/nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 520864950C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21272-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]



On Tue, Apr 28, 2026, at 3:09 AM, Jeff Layton wrote:
> Re-posting the set per Christian's request. The only difference in this
> version is a small error handling fix in alloc_init_dir_deleg(). The old
> version could crash since release_pages() can't handle an array with
> NULL pointers in it.
>
> ---------------------------------8<------------------------------------
>
> This patchset builds on the directory delegation work we did a few
> months ago, to add support for CB_NOTIFY callbacks for some events. In
> particular, creates, unlinks and renames. The server also sends updated
> directory attributes in the notifications. With this support, the client
> can register interest in a directory and get notifications about changes
> within it without losing its lease.
>
> The series starts with patches to allow the vfs to ignore certain types
> of events on directories. nfsd can then request these sorts of
> delegations on directories, and then set up inotify watches on the
> directory to trigger sending CB_NOTIFY events.
>
> This has mainly been tested with pynfs, with some new testcases that
> I'll be posting soon. They seem to work fine with those tests, but I
> don't think we'll want to merge these until we have a complete
> client-side implementation to test against.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - Fix error handling in alloc_init_dir_deleg()
> - Link to v2: 
> https://lore.kernel.org/r/20260416-dir-deleg-v2-0-851426a550f6@kernel.org
>
> Changes in v2:
> - Fix __break_lease handling with different lease types on flc_lease 
> list
> - Add FSNOTIFY_EVENT_RENAME data type to properly handle 
> cross-directory rename events
> - Display fsnotify mask symbolically in tracepoints
> - New tracepoint in fsnotify()
> - Recalc fsnotify mask after unlocking lease instead of before
> - Don't notify client that is making the changes
> - After sending CB_NOTIFY, requeue if new events came in while running
> - Document removal of NFS4_VERIFIER_SIZE/NFS4_FHSIZE from UAPI headers
> - Properly release nfsd_dir_fsnotify_group on server shutdown
> - Link to v1: 
> https://lore.kernel.org/r/20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org
>
> ---
> Jeff Layton (28):
>       filelock: pass current blocking lease to 
> trace_break_lease_block() rather than "new_fl"
>       filelock: add support for ignoring deleg breaks for dir change 
> events
>       filelock: add a tracepoint to start of break_lease()
>       filelock: add an inode_lease_ignore_mask helper
>       fsnotify: new tracepoint in fsnotify()
>       fsnotify: add fsnotify_modify_mark_mask()
>       fsnotify: add FSNOTIFY_EVENT_RENAME data type
>       nfsd: check fl_lmops in nfsd_breaker_owns_lease()
>       nfsd: add protocol support for CB_NOTIFY
>       nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
>       nfsd: allow nfsd to get a dir lease with an ignore mask
>       nfsd: update the fsnotify mark when setting or removing a dir 
> delegation
>       nfsd: make nfsd4_callback_ops->prepare operation bool return
>       nfsd: add callback encoding and decoding linkages for CB_NOTIFY
>       nfsd: use RCU to protect fi_deleg_file
>       nfsd: add data structures for handling CB_NOTIFY
>       nfsd: add notification handlers for dir events
>       nfsd: add tracepoint to dir_event handler
>       nfsd: apply the notify mask to the delegation when requested
>       nfsd: add helper to marshal a fattr4 from completed args
>       nfsd: allow nfsd4_encode_fattr4_change() to work with no export
>       nfsd: send basic file attributes in CB_NOTIFY
>       nfsd: allow encoding a filehandle into fattr4 without a svc_fh
>       nfsd: add a fi_connectable flag to struct nfs4_file
>       nfsd: add the filehandle to returned attributes in CB_NOTIFY
>       nfsd: properly track requested child attributes
>       nfsd: track requested dir attributes
>       nfsd: add support to CB_NOTIFY for dir attribute changes
>
>  Documentation/sunrpc/xdr/nfs4_1.x    | 264 ++++++++++++++-
>  fs/attr.c                            |   2 +-
>  fs/locks.c                           | 118 +++++--
>  fs/namei.c                           |  31 +-
>  fs/nfsd/filecache.c                  |  70 +++-
>  fs/nfsd/nfs4callback.c               |  60 +++-
>  fs/nfsd/nfs4layouts.c                |   5 +-
>  fs/nfsd/nfs4proc.c                   |  17 +
>  fs/nfsd/nfs4state.c                  | 551 ++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4xdr.c                    | 323 +++++++++++++++++--
>  fs/nfsd/nfs4xdr_gen.c                | 601 ++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfs4xdr_gen.h                |  20 +-
>  fs/nfsd/state.h                      |  72 ++++-
>  fs/nfsd/trace.h                      |  23 ++
>  fs/nfsd/xdr4.h                       |   5 +
>  fs/nfsd/xdr4cb.h                     |  12 +
>  fs/notify/fsnotify.c                 |   5 +
>  fs/notify/mark.c                     |  29 ++
>  fs/posix_acl.c                       |   4 +-
>  fs/xattr.c                           |   4 +-
>  include/linux/filelock.h             |  54 +++-
>  include/linux/fsnotify.h             |   8 +-
>  include/linux/fsnotify_backend.h     |  21 ++
>  include/linux/nfs4.h                 | 127 --------
>  include/linux/sunrpc/xdrgen/nfs4_1.h | 291 ++++++++++++++++-
>  include/trace/events/filelock.h      |  38 ++-
>  include/trace/events/fsnotify.h      |  51 +++
>  include/trace/misc/fsnotify.h        |  35 ++
>  include/uapi/linux/nfs4.h            |   2 -
>  29 files changed, 2519 insertions(+), 324 deletions(-)
> ---
> base-commit: f4d71dd7fd9cec357c32431fa55c107b96008312
> change-id: 20260325-dir-deleg-339066dd1017
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

For the series:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

