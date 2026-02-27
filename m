Return-Path: <linux-nfs+bounces-19424-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNGGI/fKoWm8wQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19424-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:48:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF701BAFC4
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 977373084F0F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F226C270545;
	Fri, 27 Feb 2026 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="AsZRArcr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9A346FB3
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210844; cv=pass; b=aGXEFL2N1HaSUS1z+ySQ089ATkbTm7ihs7lwsjiTz3CXS3kIloqKputZEdsnZbfq4Bpat2M0vPKbPn+jQ48wVanSwAsmKCl8zCJYa5/vqJ8dsUCnJkUjaBAqIoxvKcE/FPZkEVS9btEEWeewvSPIRHFBNbZSgso3JSYxk6/jF2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210844; c=relaxed/simple;
	bh=EtniMrkccfrrFst83snpcJ9FJYzCqUqT1Eux3rWxpmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYd+K70N+wk3HC3yH0enAOJr/fFzfL5hCoRpmTdD8TMBPCf16R535Vr7d8u6dGUXFNjuusACHoIpO/qn5CkcdNwKXtQtv1qkbFkc3e2JKdWQqaEgIRng+4IJzXFMl31l8eWqIjq3nUZYauIWT6+dx+oDsW4rjHXRF0DXT82XfQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=AsZRArcr; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 71CFE3FE54
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1772210832;
	bh=BKQzT9t7ZI3mb+6EDIKBTxaX0DX68JkIAcPYLBp08+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AsZRArcr+IHOjGSBnonu/oj477dSluZfbYqix5/Y3zCBdoV1+uw6mYYHWwc4sPEzW
	 HjFcFZE09FnavTkEnrKbxmF0r3YbTQPiFMojDWqkufdWKDMCZW9OPxWmPLHGl8VYyP
	 aEEDR142r/egN11v+6BUwh9UCjnO7iqcqVKNlvjuimRs6gHHfWgooiT0xYazkycZV9
	 iGaNpfepDa56QYdI4I7j3O9bAMZ5DH4c2WTlkXndqNrhlLiQOUUvwizjaREzzR+RaW
	 G6qhyP2mK34/AwEY8BsSjxU/P2yJBLCVcFF0FazsuIIhPpIJJoppDe/KKLv377XKJO
	 ckRoiSwBJ3h5NMgLM0yT68s2FLDl6gyLkP/lRN3fVuLZu1yxgjda/ENN1odqNnDS9i
	 cUltWCZdejwVb0iOVt7w8SJ+e7iURRxp5NxrVK346lnXyAMDOroqzltJLwTrKWTFrE
	 AN4ruGpriTmmvQ9GwGNvr1LpOw6mwnclV+8SKwiXFM2kWGMs7WC4UqqVSYW/5oxS+O
	 xoiqh6Acy+TYgniHFTAsDU75wpJzuZLSiIVgwW31LUadIpejlNvpg5EcfEaBbQmLVj
	 NgnJJyPdPSKozzmB9LKkQNdrUwMQftfhfgs3hHlvFhllpGK5m8UgazcxDHxIY0+WhT
	 Efp718XcrpREHjvzQoHFxdjs=
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64cad8f8d03so4108378d50.1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 08:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772210831; cv=none;
        d=google.com; s=arc-20240605;
        b=ITnSQFZr/qMgug0g6Xfzd9lzUkGINu0/9pHCBp9FAYnrZkPE2h7BMWt9H6WEAuzUEp
         ZTXcHCBxTXreWHW3Wj7MgimNRs+DcVOywQ9/uRGeamkFIUtSPbCL3rxAyxXGKpJ3Kz4g
         KUQmI5tvWGI395gJEAMVf1hC3uzbZFo228NCaMgp6nfrE7+98SX/x5yFLkfffcNpC6zP
         raq9Dc/JWieVYlLp06dK8Eja+soER1lEAloBEotoh2mN43Qsz8KsQPTFN94A8+H54d4a
         NPgtXfMbKBiu+H1g/KnmhUE6NT00yR5vJ7yY64CVpd+2u29/5WJG7r2hW228cNbqULAO
         bBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=BKQzT9t7ZI3mb+6EDIKBTxaX0DX68JkIAcPYLBp08+M=;
        fh=A/66qC9aFQ57EEVRQYwpypJtSTzduZ1/JFdgHSDUefg=;
        b=QCgvPHd+C7A1KxQZ6b+jSRgv6Ju21efyqYvuVU65Bx3owe0ZEZBii6G3QxqBDDOWQ4
         AVb2gqVawy5WWCbbIRptDitC6JcRgPHycZFdsJdouTn8N7UPNo3xcD8ltjHEjzP16BUq
         y5uvJ4Sj9Xs+lA5xrnHAodnLuRxgzkw/jTbFvdv8SY8d23MxBQyNsJVHAG5zSqA2tP2x
         DKeO5VnScxSGytsb4uhP8TJTaR5AfctTvXCNTwgPpPePsrBkG007VSnvk7AvPFzd0mzZ
         I4nOzIPPsILgE5i34r9FOa3xT/D11olCyxIEDRrFh6C7w0ZMl6VJiCGag+oN9bQv0yzU
         uvFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210831; x=1772815631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKQzT9t7ZI3mb+6EDIKBTxaX0DX68JkIAcPYLBp08+M=;
        b=nGDhztipy5c5umketKZLhyGM/gfW8B9xFCmeV3XjRiVxq55M36PoOdaZt2LPbRPBwI
         8MwLV65ZByOvx6fKMF7kOFGPxtDGF9F8EMZ2kUeH7xCNAbBjEtmPYHxNz+QxgwaK2Y/g
         w/FR+JgsGeaSGSdo8pK4CeKpl+wnnA5W4aOQH9LaJCmKTmetYJ12bIUweJqaXi7E/b+1
         EV1JEzo2jzNpdQbXlCDJ5YkvyGSAJPX2HK9fawmXlK5CDE85ogTx6HCjIPGkVs8qHSi3
         lOYzCu9VrX9B4Z5fDdMVnqwHP928YSTsa5hYW2zYVJrxJM00Y3aW72m0WJ1cwe/OjQfr
         PfGA==
X-Forwarded-Encrypted: i=1; AJvYcCXygk6c4E8IfBnPWs+UC3y+p+kISllORqAF3l0PHZ2swD7B3eUCnamsWX9QVjR3cm+kr0Hrt7p7Y1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YytiojjU1r/d73j0IyDhBB7gnSUpqwk3KP6WeRmfDA/ggyzchnI
	CI+1UQW3489mJKthpcpBkHJoH0CU1zhVNwEDpmxPifMyK/LVIVn01lLrHcFZLaBM91zuiREqr1m
	dNHRMWAwdwMwIN9H12i/eyWhNLNP4q6XGns8ViOt6WVLB/m+DsdPRXH26Ja+8aPUgryj/FVXc59
	6BtRhR6JtEXovu+5bq0pJkWR8egs8oxDh3+U7Bog+bSdKxUgXpA2vm
X-Gm-Gg: ATEYQzzAS13Gx+f1Bk85t4DtTSXT+uDDFWsjWLhWSUqEIqpFRJ1Bea9KMjZLzmZAixD
	xEzfbk99SYqgCoFofovLJkT4L107X8lOeVnMWW28BweaabgntPy6WbsriJDJp9B5lmAA0eBtyta
	6MEu8YhfR+AdZOFhWewtzf0WC7DLIitTCi7bz4uV3ak9hxR/r6rDRnu8GHkcF7eyQh3SexmCgEK
	MDN4jSUulfuy017j0AsguK1b0VPKKJNqp3g5bYOOsOe6UB+v9Dmqx5c4kVjemWossE=
X-Received: by 2002:a53:b743:0:b0:64c:9b84:92ee with SMTP id 956f58d0204a3-64cb6f438a9mr3821189d50.31.1772210830744;
        Fri, 27 Feb 2026 08:47:10 -0800 (PST)
X-Received: by 2002:a53:b743:0:b0:64c:9b84:92ee with SMTP id
 956f58d0204a3-64cb6f438a9mr3821130d50.31.1772210830102; Fri, 27 Feb 2026
 08:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org> <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Fri, 27 Feb 2026 08:46:58 -0800
X-Gm-Features: AaiRm50sr0j0-BwzNnmwGRvH8jyB1wNkHgZo3vdp3K_4YIT1mBOH-BzuS2c5S3A
Message-ID: <CAKCV-6ujQK3yj8sB2eHafaw4pvrJUeK18Hu4vzvNSjH48RVgYg@mail.gmail.com>
Subject: Re: [PATCH 51/61] security: update audit format strings for u64 i_ino
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19424-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.lee@canonical.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,canonical.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF701BAFC4
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 9:13=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Update %lu/%ld to %llu/%lld in security audit logging functions that
> print inode->i_ino, since i_ino is now u64.
>
> Files updated: apparmor/apparmorfs.c, integrity/integrity_audit.c,
> ipe/audit.c, lsm_audit.c.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/apparmor/apparmorfs.c       |  4 ++--
>  security/integrity/integrity_audit.c |  2 +-
>  security/ipe/audit.c                 |  2 +-
>  security/lsm_audit.c                 | 10 +++++-----
>  security/selinux/hooks.c             |  4 ++--
>  security/smack/smack_lsm.c           | 12 ++++++------
>  6 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 2f84bd23edb69e7e69cb097e554091df0132816d..7b645f40e71c956f216fa6a7d=
69c3ecd4e2a5ff4 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -149,7 +149,7 @@ static int aafs_count;
>
>  static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
>  {
> -       seq_printf(seq, "%s:[%lu]", AAFS_NAME, d_inode(dentry)->i_ino);
> +       seq_printf(seq, "%s:[%llu]", AAFS_NAME, d_inode(dentry)->i_ino);
>         return 0;
>  }
>
> @@ -2644,7 +2644,7 @@ static int policy_readlink(struct dentry *dentry, c=
har __user *buffer,
>         char name[32];

I have confirmed that the buffer is still big enough for a 64-bit inode num=
ber.

>         int res;
>
> -       res =3D snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
> +       res =3D snprintf(name, sizeof(name), "%s:[%llu]", AAFS_NAME,
>                        d_inode(dentry)->i_ino);
>         if (res > 0 && res < sizeof(name))
>                 res =3D readlink_copy(buffer, buflen, name, strlen(name))=
;

For the AppArmor portion:

Reviewed-By: Ryan Lee <ryan.lee@canonical.com>

> diff --git a/security/integrity/integrity_audit.c b/security/integrity/in=
tegrity_audit.c
> index 0ec5e4c22cb2a1066c2b897776ead6d3db72635c..d8d9e5ff1cd22b091f462d1e8=
3d28d2d6bd983e9 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -62,7 +62,7 @@ void integrity_audit_message(int audit_msgno, struct in=
ode *inode,
>         if (inode) {
>                 audit_log_format(ab, " dev=3D");
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -               audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +               audit_log_format(ab, " ino=3D%llu", inode->i_ino);
>         }
>         audit_log_format(ab, " res=3D%d errno=3D%d", !result, errno);
>         audit_log_end(ab);
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index 3f0deeb54912730d9acf5e021a4a0cb29a34e982..93fb59fbddd60b56c0b22be2a=
38b809ef9e18b76 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -153,7 +153,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const=
 ctx,
>                 if (inode) {
>                         audit_log_format(ab, " dev=3D");
>                         audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -                       audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +                       audit_log_format(ab, " ino=3D%llu", inode->i_ino)=
;
>                 } else {
>                         audit_log_format(ab, " dev=3D? ino=3D?");
>                 }
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 7d623b00495c14b079e10e963c21a9f949c11f07..737f5a263a8f79416133315ed=
f363ece3d79c722 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -202,7 +202,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>                 if (inode) {
>                         audit_log_format(ab, " dev=3D");
>                         audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -                       audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +                       audit_log_format(ab, " ino=3D%llu", inode->i_ino)=
;
>                 }
>                 break;
>         }
> @@ -215,7 +215,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>                 if (inode) {
>                         audit_log_format(ab, " dev=3D");
>                         audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -                       audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +                       audit_log_format(ab, " ino=3D%llu", inode->i_ino)=
;
>                 }
>                 break;
>         }
> @@ -228,7 +228,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>                 if (inode) {
>                         audit_log_format(ab, " dev=3D");
>                         audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -                       audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +                       audit_log_format(ab, " ino=3D%llu", inode->i_ino)=
;
>                 }
>
>                 audit_log_format(ab, " ioctlcmd=3D0x%hx", a->u.op->cmd);
> @@ -246,7 +246,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>                 if (inode) {
>                         audit_log_format(ab, " dev=3D");
>                         audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -                       audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +                       audit_log_format(ab, " ino=3D%llu", inode->i_ino)=
;
>                 }
>                 break;
>         }
> @@ -265,7 +265,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>                 }
>                 audit_log_format(ab, " dev=3D");
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -               audit_log_format(ab, " ino=3D%lu", inode->i_ino);
> +               audit_log_format(ab, " ino=3D%llu", inode->i_ino);
>                 rcu_read_unlock();
>                 break;
>         }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1ac273aac1fb52324f00b3301ae75..150ea86ebc1f7c7f8391af410=
9a3da82b12d00d2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1400,7 +1400,7 @@ static int inode_doinit_use_xattr(struct inode *ino=
de, struct dentry *dentry,
>         if (rc < 0) {
>                 kfree(context);
>                 if (rc !=3D -ENODATA) {
> -                       pr_warn("SELinux: %s:  getxattr returned %d for d=
ev=3D%s ino=3D%ld\n",
> +                       pr_warn("SELinux: %s:  getxattr returned %d for d=
ev=3D%s ino=3D%lld\n",
>                                 __func__, -rc, inode->i_sb->s_id, inode->=
i_ino);
>                         return rc;
>                 }
> @@ -3477,7 +3477,7 @@ static void selinux_inode_post_setxattr(struct dent=
ry *dentry, const char *name,
>                                            &newsid);
>         if (rc) {
>                 pr_err("SELinux:  unable to map context to SID"
> -                      "for (%s, %lu), rc=3D%d\n",
> +                      "for (%s, %llu), rc=3D%d\n",
>                        inode->i_sb->s_id, inode->i_ino, -rc);
>                 return;
>         }
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 98af9d7b943469d0ddd344fc78c0b87ca40c16c4..7e2f54c17a5d5c70740bbfa92=
ba4d4f1aca2cf22 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -182,7 +182,7 @@ static int smk_bu_inode(struct inode *inode, int mode=
, int rc)
>         char acc[SMK_NUM_ACCESS_TYPE + 1];
>
>         if (isp->smk_flags & SMK_INODE_IMPURE)
> -               pr_info("Smack Unconfined Corruption: inode=3D(%s %ld) %s=
\n",
> +               pr_info("Smack Unconfined Corruption: inode=3D(%s %lld) %=
s\n",
>                         inode->i_sb->s_id, inode->i_ino, current->comm);
>
>         if (rc <=3D 0)
> @@ -195,7 +195,7 @@ static int smk_bu_inode(struct inode *inode, int mode=
, int rc)
>
>         smk_bu_mode(mode, acc);
>
> -       pr_info("Smack %s: (%s %s %s) inode=3D(%s %ld) %s\n", smk_bu_mess=
[rc],
> +       pr_info("Smack %s: (%s %s %s) inode=3D(%s %lld) %s\n", smk_bu_mes=
s[rc],
>                 tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
>                 inode->i_sb->s_id, inode->i_ino, current->comm);
>         return 0;
> @@ -214,7 +214,7 @@ static int smk_bu_file(struct file *file, int mode, i=
nt rc)
>         char acc[SMK_NUM_ACCESS_TYPE + 1];
>
>         if (isp->smk_flags & SMK_INODE_IMPURE)
> -               pr_info("Smack Unconfined Corruption: inode=3D(%s %ld) %s=
\n",
> +               pr_info("Smack Unconfined Corruption: inode=3D(%s %lld) %=
s\n",
>                         inode->i_sb->s_id, inode->i_ino, current->comm);
>
>         if (rc <=3D 0)
> @@ -223,7 +223,7 @@ static int smk_bu_file(struct file *file, int mode, i=
nt rc)
>                 rc =3D 0;
>
>         smk_bu_mode(mode, acc);
> -       pr_info("Smack %s: (%s %s %s) file=3D(%s %ld %pD) %s\n", smk_bu_m=
ess[rc],
> +       pr_info("Smack %s: (%s %s %s) file=3D(%s %lld %pD) %s\n", smk_bu_=
mess[rc],
>                 sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
>                 inode->i_sb->s_id, inode->i_ino, file,
>                 current->comm);
> @@ -244,7 +244,7 @@ static int smk_bu_credfile(const struct cred *cred, s=
truct file *file,
>         char acc[SMK_NUM_ACCESS_TYPE + 1];
>
>         if (isp->smk_flags & SMK_INODE_IMPURE)
> -               pr_info("Smack Unconfined Corruption: inode=3D(%s %ld) %s=
\n",
> +               pr_info("Smack Unconfined Corruption: inode=3D(%s %lld) %=
s\n",
>                         inode->i_sb->s_id, inode->i_ino, current->comm);
>
>         if (rc <=3D 0)
> @@ -253,7 +253,7 @@ static int smk_bu_credfile(const struct cred *cred, s=
truct file *file,
>                 rc =3D 0;
>
>         smk_bu_mode(mode, acc);
> -       pr_info("Smack %s: (%s %s %s) file=3D(%s %ld %pD) %s\n", smk_bu_m=
ess[rc],
> +       pr_info("Smack %s: (%s %s %s) file=3D(%s %lld %pD) %s\n", smk_bu_=
mess[rc],
>                 sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
>                 inode->i_sb->s_id, inode->i_ino, file,
>                 current->comm);
>
> --
> 2.53.0
>
>

