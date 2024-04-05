Return-Path: <linux-nfs+bounces-2668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E8F899F35
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 16:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F785283DA7
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20316EBE4;
	Fri,  5 Apr 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhUxvHxX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2A16EBF2
	for <linux-nfs@vger.kernel.org>; Fri,  5 Apr 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326475; cv=none; b=OulYsorvW5JiG7OFmitdddaWKZKK3w+YhC4SzJ/St90Vd0o3ueVoYI0dGJjC79vnhUfUHMo7UmpOgTQmKKqRyoBVx9ACmdFYhS9gpCfOU85age/Xg5veIZ9GZ1L7IngW1PU4oEOpkBlNxHWIQjBsyqkgaQ1qwjsRafRT+N1XKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326475; c=relaxed/simple;
	bh=bSrWJk5ps14G/1xSno1shGJXyi+l8RQ6d/npf4JUN2I=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iIzQ1iULbGayEyFhAZYMy1fOP8jy72vIvi3zXPtapZgvQ8GUmA4Jw03b/mtXcK3mgk1ROcjGbFrq2BHSAQ72NS4kmZZadSZnijq2UBC1Bxxlm8n5jx2nE6bDyx8v69qZ/5sYGMaQrHjXNSqr6xMg/33MLPHsLEcSfa2aREP31N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhUxvHxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E727C433C7;
	Fri,  5 Apr 2024 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712326474;
	bh=bSrWJk5ps14G/1xSno1shGJXyi+l8RQ6d/npf4JUN2I=;
	h=Subject:From:To:Cc:Date:From;
	b=ZhUxvHxX7+EhJ567usXJH6QtglI3ssMkrkq2Z3QtTJLId/OmPfP2S6oLy/BGtz2Gu
	 FMm5KZWkEsoJeefCDyTrtuQx1K4MOumkd4y4lnes7yJhuJacCOzj7QN7QEMI7mh9Ca
	 BeBvjudnunWliq9jbsnxQUQoNMBK74RlfmfdAeieai4JpPRQZ4LjdzShXXkfp1MUTT
	 HS0Rg7QwRnXeDsURTZhA61dNHSaJhyhRsUjqMezTJxh8fCIo1G9K+FZow0wteRGlaQ
	 z5dKTdAlbBzMNJEt/b2nVICdzGUpa/6FT5BlfDamRRw50v/QtHDltCoH9FQV4P5acs
	 Hl6TdxNqEX56A==
Message-ID: <f3907cfe9dc83adc8e1035cbd8b37da42b1f5be6.camel@kernel.org>
Subject: server continually returns NFS4ERR_DELAY to CREATE_SESSION
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, Vladimir Benes <vbenes@redhat.com>
Date: Fri, 05 Apr 2024 10:14:33 -0400
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Vladimir reported a problem running a certain set of testcases. These
tests would spin up a number of QEMU/KVM guests that use nfsroot.

After running for a while, they eventually reboot, and that boot hangs
mounting the server because the server is continually returning
NFS4ERR_DELAY on a CREATE_SESSION operation. With the addition of some
new tracepoints that I'll eventually post, I think I have a handle on
what's happening:

First, server decides to issue a CB_RECALL_ANY to the client, but there
is a fault on the callback channel:

            nfsd-42728   [000] .......  1678.271093: nfsd_fh_verify: xid=3D=
0x9109236c fh_hash=3D0x4394a635 type=3D0x0 access=3DBYPASS_GSS
            nfsd-42728   [000] .......  1678.271093: nfsd_compound_status: =
op=3D2/3 OP_PUTFH status=3D0
            nfsd-42728   [000] .......  1678.271093: nfsd_fh_verify: xid=3D=
0x9109236c fh_hash=3D0x4394a635 type=3DLNK access=3D
            nfsd-42728   [000] .......  1678.271095: nfsd_compound_status: =
op=3D3/3 OP_READLINK status=3D0
    kworker/u8:5-459     [002] .......  1690.685190: nfsd_cb_recall_any: ad=
dr=3D192.168.50.101:833 client 660ffa56:69849ebb keep=3D0 bmval0=3DRDATA_DL=
G
    kworker/u8:5-459     [002] .......  1690.685191: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (first try)
    kworker/u8:5-459     [002] .......  1690.685194: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DUP
    kworker/u8:0-42764   [002] .......  1699.821526: nfsd_cb_seq_status: ta=
sk:00000001@00000003 sessionid=3D660ffa56:69849ebb:0000001e:00000000 tk_sta=
tus=3D-5 seq_status=3D1
    kworker/u8:0-42764   [002] .......  1699.821527: nfsd_cb_new_state: add=
r=3D192.168.50.101:0 client 660ffa56:69849ebb state=3DFAULT
    kworker/u8:0-42764   [002] .......  1699.821528: nfsd_cb_restart: addr=
=3D192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (first t=
ry)
    kworker/u8:0-42764   [002] .......  1699.821533: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (need resta=
rt)
    kworker/u8:0-42764   [002] .......  1699.821538: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DFAULT
    kworker/u8:0-42764   [003] .......  1709.037319: nfsd_cb_seq_status: ta=
sk:00000002@00000003 sessionid=3D660ffa56:69849ebb:0000001e:00000000 tk_sta=
tus=3D-5 seq_status=3D1
    kworker/u8:0-42764   [003] .......  1709.037320: nfsd_cb_restart: addr=
=3D192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (first t=
ry)
    kworker/u8:0-42764   [003] .......  1709.037325: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (need resta=
rt)
    kworker/u8:0-42764   [003] .......  1709.037327: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DFAULT

This repeats for a while over several seconds. Eventually the server
tries to probe the callback channel, but it's DOWN. Cue more
nfsd_cb_queue/nfsd_cb_start calls repeating over time:

    kworker/u8:3-42      [003] .......  1773.550044: nfsd_cb_restart: addr=
=3D192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (first t=
ry)
    kworker/u8:3-42      [003] .......  1773.550049: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (need resta=
rt)
    kworker/u8:3-42      [003] .......  1773.550053: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DFAULT
            nfsd-42728   [000] ....1..  1781.401822: nfsd_cb_lost: addr=3D1=
92.168.50.101:0 client 660ffa56:69849ebb state=3DFAULT
            nfsd-42728   [000] ....2..  1781.401823: nfsd_cb_probe: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DFAULT
            nfsd-42728   [000] ....2..  1781.401823: nfsd_cb_new_state: add=
r=3D192.168.50.101:0 client 660ffa56:69849ebb state=3DUNKNOWN
            nfsd-42728   [000] ....2..  1781.401824: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D00000000c4627b33 (first try)
    kworker/u8:3-42      [000] .......  1781.401832: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DUNKNOWN
    kworker/u8:5-459     [003] .......  1781.401833: nfsd_cb_seq_status: ta=
sk:0000000a@00000003 sessionid=3D660ffa56:69849ebb:0000001e:00000000 tk_sta=
tus=3D-107 seq_status=3D1
    kworker/u8:3-42      [000] .......  1781.401833: nfsd_cb_bc_update: add=
r=3D192.168.50.101:0 client 660ffa56:69849ebb cb=3D00000000c4627b33 (first =
try)
    kworker/u8:3-42      [000] .......  1781.401833: nfsd_cb_bc_shutdown: a=
ddr=3D192.168.50.101:0 client 660ffa56:69849ebb cb=3D00000000c4627b33 (firs=
t try)
    kworker/u8:5-459     [003] .......  1781.401833: nfsd_cb_restart: addr=
=3D192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (first t=
ry)
    kworker/u8:5-459     [003] .......  1781.401836: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (need resta=
rt)
    kworker/u8:3-42      [000] .......  1781.401858: nfsd_cb_new_state: add=
r=3D192.168.50.101:0 client 660ffa56:69849ebb state=3DDOWN
    kworker/u8:3-42      [000] .......  1781.401858: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D00000000c4627b33 (first try)
    kworker/u8:3-42      [000] .......  1781.401859: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DDOWN

Eventually, the client calls back (after rebooting), but it can't get throu=
gh:
    kworker/u8:3-42      [000] .......  1782.391951: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DDOWN
    kworker/u8:3-42      [000] .......  1782.391951: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D00000000c4627b33 (first try)
    kworker/u8:3-42      [000] .......  1782.391952: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DDOWN
    kworker/u8:3-42      [000] .......  1782.391952: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (need resta=
rt)
            nfsd-42728   [000] .......  1782.409010: nfsd_compound: xid=3D0=
xa299edc2 opcnt=3D1 tag=3D
            nfsd-42728   [000] ....1..  1782.409039: nfsd_clid_verf_mismatc=
h: client 660ffa56:69849ebb verf=3D0x17c364ee8596f72a, updated=3D0x17c3650a=
fe9e0a7f from addr=3D192.168.50.101:926
            nfsd-42728   [000] .......  1782.409041: nfsd_compound_status: =
op=3D1/1 OP_EXCHANGE_ID status=3D0
            nfsd-42728   [000] .......  1782.409241: nfsd_compound: xid=3D0=
xa399edc2 opcnt=3D1 tag=3D
            nfsd-42728   [000] ....1..  1782.409245: nfsd_clid_verf_mismatc=
h: client 660ffa56:69849ebb verf=3D0x17c364ee8596f72a, updated=3D0x17c3650a=
fe9e0a7f from addr=3D192.168.50.101:926
            nfsd-42728   [000] .......  1782.409245: nfsd_compound_status: =
op=3D1/1 OP_EXCHANGE_ID status=3D0
            nfsd-42728   [000] .......  1782.409309: nfsd_compound: xid=3D0=
xa499edc2 opcnt=3D1 tag=3D
            nfsd-42728   [000] ....1..  1782.409325: check_slot_seqid: seqi=
d=3D1 slot_seqid=3D0 inuse=3D0 conf=3D0 ret=3D0
            nfsd-42728   [000] ....1..  1782.409326: mark_client_expired_lo=
cked: addr=3D192.168.50.101:0 client 660ffa56:69849ebb error=3D10008
            nfsd-42728   [000] .......  1782.409329: nfsd_compound_status: =
op=3D1/1 OP_CREATE_SESSION status=3D10008
    kworker/u8:3-42      [000] .......  1782.417901: nfsd_cb_start: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb state=3DDOWN
    kworker/u8:3-42      [000] .......  1782.417901: nfsd_cb_queue: addr=3D=
192.168.50.101:0 client 660ffa56:69849ebb cb=3D000000006e42ee91 (need resta=
rt)

The EXCHANGE_ID works, but CREATE_SESSION returns NFS4ERR_DELAY because
it couldn't unhash the client due the refcount (cl_rpc_users) being
high. I didn't capture the value of the refcount at this point, but the
CB_RECALL_ANY job holds a reference to the old client, so that would be
enough to prevent unhashing it.

I think we need to rework the refcounting on the CB_RECALL_ANY job, at a
minimum. It probably shouldn't hold a reference to the client. Maybe
make it store the clientid and just redo the lookup if it's still
around? I might try to spin up a patch along those lines.

Longer term, I think we need to take a hard look at why the cl_rpc_users
refcount ensures that the client remains hashed. It seems like we ought
to be able to unhash it, even if there are outstanding references, no?

Thoughts on other ways to fix this or other structural fixes?
--=20
Jeff Layton <jlayton@kernel.org>

