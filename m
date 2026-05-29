Return-Path: <linux-nfs+bounces-22065-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ElILN3YGGpDoAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22065-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 02:07:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C075FB982
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 02:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739B7301C59C
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5766FC5;
	Fri, 29 May 2026 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2cny6Ok"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F083FFD
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013244; cv=none; b=JBymTs65TmDfyVTAKTn59jOLbmFQfv9UdSNSVbz8wGbE8Z7mHff2UJDWB3FQsyo4UctFH0au73wuXGP3BqAGmr42E2v88nvBQnCA/C+ZYKNeUY1MlwezGlGqtRLVJ7lPdb1wOMe2iNsmBeM0rwZmLOFwKv7bNWm5BaKq/oNP/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013244; c=relaxed/simple;
	bh=3psYEO2qpO1FykauT6/zRFo7HjuY7oUNiiRkWoe1+jk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TGorEupcz9S2vZwPBSG/CoozwHsh1+KijhZojYLOwnhL0H9QsWF9bywHElmFVd433K9KbXyhUkDpBdJ9+LbDtdhGQDenTDP78xu8VTmPT4UWh6X7G6zmKlrfkQKjjm6wHJQrvE8aYWcogoV//Qso0Re9/EPm+4aXXRc3jk1dbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2cny6Ok; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7171F000E9;
	Fri, 29 May 2026 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780013242;
	bh=wozD0Tf5zoC9HU1cIdfqe1I+6WKQlr3E72DVfkpNhZQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=k2cny6OkSGKNcudx+yP4o/hZ2kZvJI/9EEYr1MGyGndw4pOA04J+12W9cLhht8emP
	 /xWlLnS4or4XiNP73oxU91w+IbHvB/5JwegmNeB2y11oOg+NVVsaGY5XrBQ9T7Hc9r
	 Tw61F4/b0Kxl82ylAu9EAfZXM/bFWvfmfBw+WoiUjKlmRCe01vrAFNPM+WKJMBFJiJ
	 G5lcefa7YIVvbLZzJFKetEANMLC67mMitIMQ1dkvQWJEuzZPawj8HJfCv+CfHNVqer
	 1cKiy71Y7LyGhdCcFUaIhJARVKIK8Ip0G5CL43D8WUPMYOX+HGXngCh+FvVqMMUvnn
	 JkCZ6WLPcUM+Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 52381F40068;
	Thu, 28 May 2026 20:07:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 28 May 2026 20:07:21 -0400
X-ME-Sender: <xms:udgYamttQsse2MkVxVFKfwkvdM7GE3wQiqQbxfPV-Dmlrxsls-x1_w>
    <xme:udgYamSMyb1BT7TvPkt0qVhK9bfxGq0nzMNQ8QIrazFNws6enFsujnKb0sXInHOjz
    EayNwWW-FUyv8T-ltH8cQ0s84NGrjXAq-bS3lAmpK-CZga0-gzUv1k>
X-ME-Proxy-Cause: dmFkZTGYlHL+As9knd9zuIguBVswMUQ5gLD3OnfgWLlvpKamPEeR0ecSkS7BGp/WSWpCk5
    STEGV+twm0SvNcAILwIo8YDGGHlGP3ax0ZqEZApFfPRxp+vPV1nKhPKCVfh5p9by3FYqc1
    pdKJa/je3UMtfwnTgi7DHqYNe730cZol8/TCZ1Vzm2W8wgN+lawA5GYN21pysIvRWJ+g05
    V/0/QC0hVybeMAs+gJFVmkWRDu3KSGI/O/rBj2Xls2BSeNX0t2rNhwuez8RT/Hn1KSkGes
    munDb3OkFjYKTni5Cl68qrBJnWBDElQHhWCdsEI2Jj3AmCGklW34xEtazIKKzmaOlwVGUJ
    dWMzvej8uaGve7SdeRyL3iOwqmlaLoxuUGNY8a9uQxf7RrpZXeOwhwO3syz5OmndBQBH27
    etUFfnkPGxb4qsqKcP29IQn/PScwF4ucgiOCDDtynwEnhI/cCrSgaLaVzZzO2TYs2l+fyz
    WCU1Sw5yKfKZ88xxPnUq4h7FShQjZPwF1e1VbjGp5mammzEiigHt6C8elCYVaIfivX2qfb
    oNh87cLBTU1jdWM/44t7vYeQ00MXWXUm0k0xpqd8Q7ZliuLHy3tlgdMUU0BEWkuYUjbEX0
    DmgSunKhi9MKA2xusBQxHddH35cJOlj3hkNReBFlW7LP3RGCioRggTuy9Rfw
X-ME-Proxy: <xmx:udgYajRf2kqBXS1StOoA7asRDk7XfBxD8zBmu2L9HK-h_Fba1qXfZA>
    <xmx:udgYaqWgJqB2RBdOu-_d90t2MGl6bSGaS4yZSVCeWON5wAX6PkuLQg>
    <xmx:udgYaiYsNCcXNF9uOMjb2IXAq1QMYyOMplQ6X7YwD_x50VK-nlN1PA>
    <xmx:udgYaj4ubxf5oJO4f7fHDlXJ3hCU8ZWoF9nP4Lf6_MUzZrGAIMRQxA>
    <xmx:udgYajyABrnsoInXMGframewtl66_r_ZG_YD0wE3W6ar4s6pKobgrk5H>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A90E780098; Thu, 28 May 2026 20:07:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 May 2026 20:07:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Rick Macklem" <rick.macklem@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>, "Chris Mason" <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <71e5e6b6-f2d6-48ca-bc66-32064a2e0798@app.fastmail.com>
In-Reply-To: <bffd1333-a65e-40d9-9553-7de4401a55bd@app.fastmail.com>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
 <CAM5tNy7sSXFUWFVkKEYVt9nLPOCT_-+7KfgZeoZ2UCv_eLMvrQ@mail.gmail.com>
 <bffd1333-a65e-40d9-9553-7de4401a55bd@app.fastmail.com>
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort cost
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22065-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09C075FB982
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 7:11 PM, Chuck Lever wrote:
> On Thu, May 28, 2026, at 6:11 PM, Rick Macklem wrote:
>> On Thu, May 28, 2026 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
>>>
>>> CAUTION: This email originated from outside of the University of Gue=
lph. Do not click links or open attachments unless you recognize the sen=
der and know the content is safe. If you are unsure, forward the message=
 to ITHelp@uoguelph.ca for review.
>>>
>>>
>>> From: Chris Mason <clm@meta.com>
>>>
>>> nfsd4_decode_posixacl() reads a u32 entry count off the wire and pas=
ses
>>> it straight to posix_acl_alloc() and sort_pacl_range(). The latter is
>>> an O(n^2) bubble sort, so a client-chosen count drives unbounded CPU=
 in
>>> the server's compound processing path.
>>>
>>>     nfsd4_decode_posixacl()
>>>       xdr_stream_decode_u32(&count)       /* uncapped u32 */
>>>       posix_acl_alloc(count, GFP_KERNEL)
>>>       sort_pacl_range(*acl, 0, count - 1) /* O(n^2) bubble sort */
>>>
>>> The encoder side in the same file already rejects ACLs whose a_count
>>> exceeds NFS_ACL_MAX_ENTRIES, but the decoder introduced in commit
>>> 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
>>> omitted the symmetric check.
>> My recollection is that Chuck didn't like this limit. He argued that =
it was
>> specific to the NFSv3 ACL protocol and that the limit on the size of =
a NFSv4
>> RPC message was sufficient.  I, personally, think that 1024 is a reas=
onable
>> limit for # of ACEs, but Chuck can jump in here if he doesn't agree.
>
> The NFSACL protocol limits the number of ACEs in an ACL to NFS_ACL_MAX=
_ENTRIES
> (1024). It=E2=80=99s a limit that is defined in the protocol itself.
>
> The NFSv4 protocol sets no similar limit. In particular, NFS_ACL_MAX_E=
NTRIES
> is not a constant defined or used by the NFSv4.x family of protocols I=
IRC.
>
> Using NFS_ACL_MAX_ENTRIES to cap the number of ACEs in NFSv4 ACLs is a
> convenience, but it adds technical debt (slight though it may be).
>
> So=E2=80=A6 We can define an implementation limit for NFSv4 ACL suppor=
t in NFSD.
> But it shouldn=E2=80=99t be called NFS_ACL_MAX_ENTRIES, IMHO. For clar=
ity of
> documentation, pick a number (could be 1024) and state in a comment th=
at
> it is an NFSD implementation constraint, not a protocol limit. Name the
> constant something like NFSD4_MAX_yada to make it clear it is an
> implementation limit, not a protocol limit.

A different take on this might be that we want to ensure that ACLs set
via the NFSv4 POSIX ACL extension can always be retrieved via NFSACL.
In that case, capping the ACE count at the same number makes sense.
As long as the reason for this is clearly mentioned.


--=20
Chuck Lever

