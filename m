Return-Path: <linux-nfs+bounces-14957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A556BB6ACC
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 902964E736F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7BB2ECD22;
	Fri,  3 Oct 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="RhdzKmb2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C2224AF2
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495207; cv=none; b=DeHyOx/2MkODNcbhcumdUbuAMo9LGXsxLCQtbgXQ6jSVfW8by8BQ4o1xdMdsmg7ADgcupUudN4X4pBaZlCk9/qcbZIGUtnVJ6Csma194RIleywB3rtx0i8U6ZEnTPUGRHQR56+6svQpuI0HIoQyvpNBTAx8gBgo158+Fw739O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495207; c=relaxed/simple;
	bh=H+I1V5mfQOYPwoPDsbMmhSRKZV+49SQXmWoIqFtRNoY=;
	h=To:cc:From:Subject:Date:Message-ID; b=iDnlQf33s8mZBVrXhh9IkG6+VTg4MVUpURD6MXFwfUIE2MtGA9QKE+sW6vQdXVAgjw/xUjKjq53l+8HJstbxbkCZX57158urgDMtQzNyEp7eWimH2ouK+YzTz6F//tjTBRcFkHwjXNN13wPiMpc+vKG5qiSNODvgzsnbREkOT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=RhdzKmb2; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nVlee3PjW8NQQNCPbSt6Xd4aw47PDG6z5G5TGA+XaQw=; t=1759495205; x=1760359205; 
	b=RhdzKmb2x9W9WTV9rGeDT5qtvMjI9t5km7i0Lsi4HgUCG7DZ/aNPuZImfun233WZX59OX0de4l4
	JBNW3Q24+LDXlOH3BuMFmiYzG2dvHKoEbKOc+3Ut05yPb0drZpR4dRIwjQireaEbvvT+/cQ1sRije
	CjzWHPPg1olENZPapKnrtycxavLFZ+CiwSIBKJ3uJMGQBJ+oNIz72LlkqCikrIZ50MUuo3VLXzUTZ
	Hn7OrCwLXf1Ux/+wGnZ5ny+oXVg502GXPOtb7Q00e8vFmYecvr6DoJC11y+0Wl7B9NPcXb9k2xwos
	H/IbRiw7qZRF1Iw7itwlg1tPOQuv+BjSI3fA==;
Received: from [24.147.175.133] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1v4ezS-002cW8-5W;
	Fri, 03 Oct 2025 08:34:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 3517129E339A;
	Fri, 03 Oct 2025 08:34:25 -0400 (EDT)
To: Chuck Lever <chuck.lever@oracle.com>,
    Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: use-after-free in nfs4stat.c _free_cpntf_state_locked()
Date: Fri, 03 Oct 2025 08:34:25 -0400
Message-ID: <83337.1759494865@localhost>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

If an NFS 4.2 client has a COPY_NOTIFY registered, and then
re-establishes its session with EXCHANGE_ID with a new verifier and
CREATE_SESSION, nfsd4_create_session() calls expire_client() for the
old session, which frees the nfs4_stid associated with the
COPY_NOTIFY. But the COPY_NOTIFY's nfs4_cpntf_state still exists; when
nfs4_laundromat() expires it, _free_cpntf_state_locked()'s
list_del(&cps->cp_list) uses the freed memory of the nfs4_stid.

A demo:

# uname -r
6.17.0-01737-g50c19e20ed2e-dirty
# cat /etc/exports
/tmp 127.0.0.1(rw,subtree_check,pnfs)
# wget http://www.rtmrtm.org/rtm/nfsd185b.c
# cc nfsd185b.c
# ./a.out
(wait 10 or 20 seconds for nfs4_laundromat())
(you may have to run a.out more than once)
list_del corruption. prev->next should be ffff8881068669d8, but was 6b6b6b6b6b6b6b6b. (prev=ffff888105190010)
kernel BUG at lib/list_debug.c:62!
Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 2 UID: 0 PID: 268 Comm: kworker/u51:2 Tainted: G        W           6.17.0-01737-g50c19e20ed2e-dirty #33 PREEMPT(voluntary) 
Workqueue: nfsd4 laundromat_main
RIP: 0010:__list_del_entry_valid_or_report+0xdd/0x110
Call Trace:
 _free_cpntf_state_locked+0x40/0xb0
 laundromat_main+0x5ec/0xaf0

The nfs4_cpntf_state is allocated and linked into the
nfs4_stid.sc_cp_list here:

#0  list_add (head=<optimized out>, new=<optimized out>)
    at fs/nfsd/nfs4state.c:985
#1  nfs4_alloc_init_cpntf_state (nn=nn@entry=0xffffffd602d82000, 
    p_stid=0xffffffd606858008) at fs/nfsd/nfs4state.c:985
#2  0xffffffff804b04e0 in nfsd4_copy_notify (rqstp=0xffffffd6040fb800, 
    cstate=<optimized out>, u=0xffffffd6052e2720) at fs/nfsd/nfs4proc.c:2078
(gdb) print cps
$1 = (struct nfs4_cpntf_state *) 0xffffffd603fe9020
(gdb) print p_stid
$2 = (struct nfs4_stid *) 0xffffffd606858008

The nfs4_stid is freed here:

#0  nfs4_free_ol_stateid (stid=0xffffffd606858008) at fs/nfsd/nfs4state.c:1502
#1  0xffffffff804c3ed2 in free_ol_stateid_reaplist (
    reaplist=reaplist@entry=0xffffffc60031baf8) at fs/nfsd/nfs4state.c:1602
#2  0xffffffff804c46fa in release_openowner (oo=0xffffffd606857008)
    at fs/nfsd/nfs4state.c:1696
#3  0xffffffff804c4898 in __destroy_client (clp=clp@entry=0xffffffd605308008)
    at fs/nfsd/nfs4state.c:2483
#4  0xffffffff804c49fa in expire_client (clp=0xffffffd605308008)
    at fs/nfsd/nfs4state.c:2533
#5  0xffffffff804c7a26 in nfsd4_create_session (rqstp=0xffffffd6040fb800, 
    cstate=<optimized out>, u=0xffffffd6052e2060) at fs/nfsd/nfs4state.c:4041
(gdb) print stid
$3 = (struct nfs4_stid *) 0xffffffd606858008
(gdb) print stid->sc_cp_list
$4 = {next = 0xffffffd603fe9038, prev = 0xffffffd603fe9038}

Freeing the nfs4_cpntf_state trips over the free nfs4_stid here:

#0  _free_cpntf_state_locked (nn=nn@entry=0xffffffd602d82000, 
    cps=0xffffffd603fe9020) at fs/nfsd/nfs4state.c:7226
#1  0xffffffff804c6210 in nfs4_laundromat (nn=0xffffffd602d82000)
    at fs/nfsd/nfs4state.c:6836
#2  laundromat_main (laundry=0xffffffd602d820d0) at fs/nfsd/nfs4state.c:6926
(gdb) print cps
$5 = (struct nfs4_cpntf_state *) 0xffffffd603fe9020
(gdb) print cps->cp_list
$6 = {next = 0xffffffd606858010, prev = 0xffffffd606858010}
(gdb) print cps->cp_list.next.prev
$7 = (struct list_head *) 0x6b6b6b6b6b6b6b6b

Robert Morris
rtm@mit.edu

