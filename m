Return-Path: <linux-nfs+bounces-21450-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VQxQJ5e0/mkYvQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21450-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 09 May 2026 06:14:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0A4FE06C
	for <lists+linux-nfs@lfdr.de>; Sat, 09 May 2026 06:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A31B301465C
	for <lists+linux-nfs@lfdr.de>; Sat,  9 May 2026 04:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9D299A82;
	Sat,  9 May 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Oa8SB8y9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRl6xyBD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFE231A23
	for <linux-nfs@vger.kernel.org>; Sat,  9 May 2026 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778300051; cv=none; b=qt2sCZluA/a4A5/YMMtQ0Mg6mw6pp/1rr44+mWfZ1pxRLArNhrTOssgRxNnpl28DBC4thmP9xAApShvpcCMXySi6Zc4aSpXlaZEPsJChME2xfza94ETHD27sp7Lp+y9imyv/QG6qaHC8cSfONT7qFl7TW5KnTJzsFjnhZ8f03QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778300051; c=relaxed/simple;
	bh=91hQF/ll3RL1GQXJrdcK9tVL35WfaxZw2Nz566ncizQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Hn/6i/bpObNZ+TiNrQyWkCZ2Lgbu41NiKJLv1857MeOZkprMlhP1GLIB8thoB2YY/PqmCD9jvxLAgJ2jj956//IO548maHztb3t6BWXijBXjOmgr5CX8Y/a/Ds/JxTM6se+fcBzWxeBDbkiWA0WhOczUBTyNhyMxyjhp0J3khzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Oa8SB8y9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRl6xyBD; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 733BC7A00FD;
	Sat,  9 May 2026 00:14:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 09 May 2026 00:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1778300047; x=1778386447; bh=TmXFe2axMw7tpzElt4IvolAhuse2IHhNZX3
	HRookdbs=; b=Oa8SB8y9Gbf/T/CuZzYbsEnXQ9nSSw9GxH//yDLifNQztckFC/p
	vxUcVg4EQGsjUHjSVVdv5umy4BG9l063dN30+v7HAL4c8QCBRLFTu/iHHx3/xHk9
	QzVlZS3X7tSQzvS6BtTxOo20b77lkTJmeOtIiLi3ywod3T34tvPq9uKmeMGwsWy6
	JH9W5ZUCmsGUUG0EECqh0D8sw6W0lbRGIego1gl50zUHFbI2RKCHQS/C76BUDJd5
	R6Qdo2gnAWIplLPFwtEyTRm2sF2ZWOMRoZHrLkQGRL9688v7LRHCZRqT4C2+imHR
	BRXrGg+GUCCXCTITLyEj8P/98BxTWgLqhPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778300047; x=
	1778386447; bh=TmXFe2axMw7tpzElt4IvolAhuse2IHhNZX3HRookdbs=; b=l
	Rl6xyBD6VE7IgI4QCgXmoam2fUpsAb7T7/Bt9e/yhMSavUPguqnk2bWP/VJlesrn
	YYkApMhy99K8yZeyyM76JBNHxJrozLx3XZl2+IAiq80EFdMjWH8c5FpYxf/jplM2
	LIvKeI6+Q5J2szN3HVYwrB6qRwE5pBjHI+WY5PDnKK+GEu7P2kMIDwtkZE4E0DPi
	vE7nnzHh1mbsYHQaNDYd1ol4bY6aCPW5V0P7nK2/FMyDHotiVMXis7eDuMKL42Qz
	D+ByJ4HyPxzVPMlHAxjhnE5Zjq62KOuy9bUDnEh5xvbCz3lUM1XaALVihmR1CSLc
	EsHoaxegOKHYhYF3D7orw==
X-ME-Sender: <xms:jrT-aW1pdqcWf0RqMdDtljY5YG-V_I_uIEENXdwXtL_Biisg54FjUw>
    <xme:jrT-acwSEF5y1ODbEZM30G96S2Zq2NmAeWYHHjJoWb4YYfY6ZXR-ccn5AYh9Hx0eH
    8Pl-WPj5r-oRWVRdAfE6C6UrGQLmb9jcW61FrMM-Bjnc3JJBg>
X-ME-Received: <xmr:jrT-aYujjgIyYXksJrhworz5kvgWtj5FCQQKq4PpLIIWhS6w3nsEcm3YTJr8qZbZzo8WR7FcHxzPR0dsWaydVWzYs0NkJ80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddvvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epkeelffejgfefteelffduudefgeevueetleekfeehheegjefhgeeivefhvddvleffnecu
    ffhomhgrihhnpehnfhhsgehprhhotgdrtggtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhl
    vghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehsvggtuhhrihhthieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhishhhihhshhgrkhihrgeftdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jrT-aezzu29DOf0jBuQNvrD-eFDLrpk-Y3cfOzAyIpA48Q8KzMrtkQ>
    <xmx:j7T-abCyMlwGgFnWin2KX3_kBsGiLDjmq8n_0j3fyy4qCTXt3EeHsQ>
    <xmx:j7T-acdTkLdT1fKxFFu8-_Fz08G9ZyKISsolx6-CWTvi2pbe1yE3rQ>
    <xmx:j7T-aVnsNK-hK9H9tlPYQy9YcrECSBevryQJKnA-mbEqT0AreYBmzg>
    <xmx:j7T-aUKdBDGTyI8lR8WDf8s0UJni-BgqgUZyx2TwJlC-nJhQJ8s3-dm2>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 00:14:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Linus Torvalds" <torvalds@linuxfoundation.org>, linux-nfs@vger.kernel.org
Cc: "Rishi Shakya" <rishishakya30@gmail.com>, security@kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: Authentication Downgrade to AUTH_SYS in NFSv4.2 Inter-Server Copy
 (nfsd4_interssc_connect)
In-reply-to:
 <CAHk-=wjjzAcUYyC4sXdThoDZex129Jmy68ng+JKSriofuSty_Q@mail.gmail.com>
References:
 <CA+XO5+XaqTQ5=DVFKct-Pj_xo0U9awjHuHhoW_1gvL0-bgGw0A@mail.gmail.com>
  <CAHk-=wjjzAcUYyC4sXdThoDZex129Jmy68ng+JKSriofuSty_Q@mail.gmail.com>
Date: Sat, 09 May 2026 14:14:00 +1000
Message-id: <177830004077.1474915.1115119001196387152@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 89F0A4FE06C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,oracle.com];
	TAGGED_FROM(0.00)[bounces-21450-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Action: no action

On Sat, 09 May 2026, Linus Torvalds wrote:
> I think this should probably be dealt with in the open. I have cc'd
> the nfsd maintainers, and I forwarded the original to them, but I
> suspect any future discussions should probably be on the appropriate
> lists.

and yet no one sent anything the the appropriate list :-)
Ok this is on the nfs list.

> Subject: Authentication Downgrade to AUTH_SYS in NFSv4.2 Inter-Server
> Copy (nfsd4_interssc_connect)
> To: <security@kernel.org>
> 
> 
> Dear Linux Kernel Security Team and NFS Maintainers,
> 
> I am writing to report a critical authentication downgrade
> vulnerability in the nfsd subsystem of the Linux Kernel. Specifically,
> the vulnerability exists in the handling of NFSv4.2 Inter-Server
> Server-to-Server Copy (SSC) requests.
> 
> When a destination server initiates an internal mount to a source
> server via nfsd4_interssc_connect(), it relies on a hardcoded macro
> (NFSD42_INTERSSC_MOUNTOPS) that strictly enforces sec=sys. This
> completely bypasses any Kerberos (GSS-API) or otherwise strict
> security policies enforced by the administrator, allowing an
> unprivileged attacker to mount arbitrary malicious NFS servers with
> uid=0 trust.

This is where you lose me.  The above line seems to be meaningless.

The NFS server does not "mount" the target filesystem (from the
malicious NFS server) in the traditional sense.  What it does is
activate the NFS client code to talk to that server.  This involves
creating an appropriate superblock and other internal data structures
that can be used by nfsd to work with the NFS client code.  This uses
the kern_mount() API.  The purpose of this API is to activate a
filesystem for kernel-internal use.   The file system never appears
in any namespace so no application other than nfsd can ever access it.

All nfsd does is open/read/close a file using a filehandle and stateid
that were supplied by the original client.  There is no way that the
"malicious" NFS server can do anything except pass back to nfsd the
contents of some file.  There is nothing it can do to affect the
privilege level of any operation at all.

It not inconceivable that the malicious server to return the data in
such a way (block size/speed/whatever) which causes some sort of
denial-of-service to nfsd, but I think that is the worst it could do and
even that seems unlikely.

Your test code only got as far as activating the NFS client.  You need to
demonstrate something more than that to demonstrate an exploit.

NeilBrown


> 
> Please find the detailed CVE report, technical analysis, and
> proof-of-concept execution logs below.
> 
> Vulnerability: NFSv4.2 Inter-Server Copy (SSC) Forced Authentication
> Downgrade (sec=sys) Target: Linux Kernel (fs/nfsd subsystem) Tested
> Version: Linux Kernel 7.1.0-rc2+ (Vulnerability exists in all versions
> supporting NFSv4.2 SSC) Severity: HIGH (Authentication Bypass / Trust
> Boundary Violation)
> 
> 1. Executive Summary
> A critical security flaw exists in the Network File System Server
> (nfsd) implementation of the Linux Kernel when handling NFSv4.2
> Inter-Server Server-to-Server Copy (SSC) operations. The
> nfsd4_interssc_connect() function establishes connections to remote
> source servers using a hardcoded mount options string that strictly
> enforces sec=sys (AUTH_SYS).
> 
> This hardcoded downgrading of security completely bypasses
> administrative configurations that mandate strict Kerberos (GSS-API)
> authentication. An unprivileged attacker can exploit this by
> instructing the victim's NFS server to copy a file from an
> attacker-controlled remote NFS server. The victim's kernel will
> connect to the malicious server using the weak AUTH_SYS protocol,
> allowing the attacker to spoof arbitrary User IDs (e.g., UID 0 / root)
> and trick the victim's kernel into ingesting malicious payloads or
> leaking sensitive state.
> 
> 2. Technical Deep Dive
> The NFSv4.2 protocol introduced the COPY operation (Opcode 60),
> allowing a client to ask a destination server to fetch data directly
> from a source server, avoiding routing the data through the client.
> 
> When the Linux kernel (nfsd) receives an inter-server COPY request,
> the execution flow is as follows:
> 
> nfsd4_copy() (in fs/nfsd/nfs4proc.c) determines if the copy is inter-server.
> It calls nfsd4_setup_inter_ssc().
> It then invokes nfsd4_interssc_connect().
> Within nfsd4_interssc_connect(), the kernel utilizes the
> vfs_kern_mount() API to mount the remote source server internally. The
> vulnerability lies in the definition of the mount string used for this
> connection.
> 
> Vulnerable Code (fs/nfsd/nfs4state.c & fs/nfsd/nfs4proc.c)
> c
> // Hardcoded mount options enforcing AUTH_SYS
> #define NFSD42_INTERSSC_MOUNTOPS "vers=4.2,addr=%s,sec=sys"
> static __be32 nfsd4_interssc_connect(struct nl4_server *nss, struct
> svc_rqst *rqstp,
>       struct nfsd4_ssc_umount_item **nsui)
> {
>     // ...
>     snprintf(raw_data, raw_len, NFSD42_INTERSSC_MOUNTOPS, ipaddr);
> 
>     // ...
>     /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>     ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>     // ...
> }
> Because the kernel implicitly trusts the attacker-provided source IP
> address and enforces sec=sys, the malicious server dictates the user
> and group permissions without requiring cryptographic proof, rendering
> any Kerberos configurations on the destination server useless.
> 
> 3. Lab Environment Setup
> To isolate and definitively prove this vulnerability, a rigorous
> testing environment was established separating the attacker (Host) and
> the victim (QEMU VM).
> 
> Victim VM Kernel: Recompiled from Linux 7.1.0-rc2+ source tree with
> CONFIG_NFSD_V4_2=y and CONFIG_NFSD_V4_2_INTER_SSC=y.
> Victim VM OS: Minimal Debian initrd.
> Attacker Host: Execution of a custom Python XDR script
> (pynfs_ssc_trigger.py) to manually craft and send NFSv4.2 compounds
> over TCP port 20490 (forwarded to VM port 2049).
> 4. Step-by-Step Exploitation & Protocol Hurdles
> Triggering the vulnerable nfsd4_interssc_connect() function required
> navigating several rigid NFSv4 protocol constraints. Here is the
> breakdown of the hurdles faced and how they were bypassed to confirm
> the exploitability of the bug. Note: Bypassing these checks was solely
> for the purpose of demonstrating the hardcoded mount parameter
> execution path using a lightweight script, as opposed to writing a
> full stateful client. A real-world client driver would naturally
> satisfy these constraints.
> 
> Hurdle 1: Minorversion Negotiation Rejection
> Issue: Initial attempts to send an NFSv4.2 compound returned 10071
> (NFS4ERR_MINOR_VERS_MISMATCH). The rpc.nfsd userspace daemon
> internally clears minor versions during startup.
> Bypass: We created a dedicated /etc/nfs.conf in the VM with [nfsd]
> vers4.2=y before starting the daemon. This successfully enabled the
> kernel to accept minorversion 2.
> Hurdle 2: Strict Session Context (NFS4ERR_OP_NOT_IN_SESSION)
> Issue: In NFSv4.1+, all operations must occur within a session
> context, requiring an OP_SEQUENCE header. Our raw exploit attempt
> threw error 10071 (which mapped to NFS4ERR_OP_NOT_IN_SESSION
> internally).
> Bypass: To focus purely on validating the sec=sys bug without building
> an entire stateful session manager in Python, we patched the test
> kernel's nfs41_check_op_ordering() function in fs/nfsd/nfs4proc.c to
> return nfs_ok. This allowed us to send raw OP_COPY compounds directly.
> Hurdle 3: Inter-Server Offload & Sync Validation (NFS4ERR_NOTSUPP)
> Issue: The OP_COPY compound returned 10022 (NFS4ERR_NOTSUPP).
> Bypass: Two constraints caused this:
> By default, Linux disables SSC. We explicitly enabled it in the VM via
> echo Y > /sys/module/nfsd/parameters/inter_copy_offload_enable.
> The Linux kernel strictly does not support synchronous inter-server
> copies. We modified our payload to set the ca_synchronous flag to 0
> (FALSE) inside the OP_COPY arguments.
> Hurdle 4: XDR Filehandle Constraints (NFS4ERR_NOFILEHANDLE)
> Issue: After resolving the previous issues, the kernel returned 10020
> (NFS4ERR_NOFILEHANDLE). Analysis of check_if_stalefh_allowed() in
> nfs4proc.c revealed that an OP_COPY explicitly requires the preceding
> operation in the compound to be OP_SAVEFH (Save File Handle).
> Bypass: We modified the exploit payload to inject OP_SAVEFH
> immediately prior to OP_COPY.
> Final Payload Compound Structure: [ OP_PUTFH (Dest_FH) ]  ->  [
> OP_SAVEFH ]  ->  [ OP_COPY (Source=Attacker_IP) ]
> 
> 5. Final Confirmation & Execution Logs
> With all protocol requirements met, the final exploit script
> successfully bypassed the validation checks and hit the sec=sys
> vulnerable function.
> 
> Attacker (Host) Execution Log:
> 
> text
> $ python3 pynfs_ssc_trigger.py
> ============================================================
> BUG-006 NFSv4.2 Inter-Server SSC Definitive Trigger v2
> ============================================================
>   Target (Victim NFSD)  : 127.0.0.1:20490
>   Source (Attacker NFS) : 10.0.2.2:2049
> [+] Connected to VM NFSD (vulnerable kernel 7.1.0-rc2)!
> [Step 1] Getting root file handle...
> [+] Root FH obtained (8 bytes): 0100010000000000...
> [Step 4] Sending COPY directly against Root FH with remote source server...
> [*] >>> This triggers nfsd4_interssc_connect() in VM kernel <<<
> [*]   Source URL: nfs://10.0.2.2/home/veronica/bot/attacker_share/pwned.txt
> [*] Sending NFSv4.2 COPY with ca_source_server = 10.0.2.2
> ============================================================
> [*] COMPOUND status: 10036 (NFS4ERR_BADXDR - expected after COPY)
> [*] PUTFH status: 0
> [*] COPY status: 0
> [*] COPY error meaning: [!!!] NFS4_OK - COPY SUCCEEDED! BUG-006 CONFIRMED!
> ============================================================
> Victim (VM) Kernel Logs:
> 
> text
> [  838.284931] NFSD BUG006-DBG: received minorversion=2, nfsd_test=1,
> nfsd4_minorversions[2]=1
> [  861.306957] NFSD BUG006-DBG: received minorversion=2, nfsd_test=1,
> nfsd4_minorversions[2]=1
> The status: 0 (NFS4_OK) returned by the kernel for the OP_COPY block
> conclusively proves that execution successfully reached and executed
> nfsd4_interssc_connect(), triggering the hardcoded sec=sys mount
> against the attacker's server.
> 
> 6. Conclusion & Remediation
> The hardcoding of sec=sys in NFSD42_INTERSSC_MOUNTOPS fundamentally
> breaks the security model of NFSv4.2 environments relying on strong
> cryptography (Kerberos).
> 
> Proposed Fix: The NFSD42_INTERSSC_MOUNTOPS definition should be
> refactored to dynamically inherit the security parameters (sec=) of
> the existing client session or the specific export policy, rather than
> forcing the weakest denominator (sec=sys). Validations must be added
> to ensure the destination server refuses SSC requests that mandate
> downgrading the negotiated authentication state.
> 
> Thank you for your time and dedication to securing the Linux kernel. I
> am available for any questions or to assist in reviewing potential
> patches.

