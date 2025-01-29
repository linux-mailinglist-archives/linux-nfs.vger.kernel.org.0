Return-Path: <linux-nfs+bounces-9762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF03FA224AD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 20:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5137316645D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077419340B;
	Wed, 29 Jan 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHbkVutP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A438191499
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738180183; cv=none; b=JNykrvwl11LsS5g0gIi2s2AlkEzYqbpZFeWyplZ/H4E8bY/ngTc5DdQGZaXgs+c1RhJNprKfKjxrrc/2zGtYe+R5URG22kFnmJONfbvAB3ykFevTOUqQHLN2w/d+PNMWIcINOx/ygiVFQgop4DKm0xadQpRiWPoWHEHYB3ASr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738180183; c=relaxed/simple;
	bh=UZqN856Uf7dbAa7XoJN09RiuenOBQi+BNBywygHORFs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=lns2RfCyCK3z+FcUXxO54NHpHgEHbwH9vNB3QPcOLRljgNkSdzLwLHRhQiRvvQDmlTmN1NbCkeMMJB7nJOja8iSogJCEPqmc6BOUzQfuYXqt/G+eOpxw7tmhGOteNzHDKTClxO8WHZuR4NhRrakS/d1ECrKLwLJiXbdHosnzbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHbkVutP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F6FC4CED1;
	Wed, 29 Jan 2025 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738180181;
	bh=UZqN856Uf7dbAa7XoJN09RiuenOBQi+BNBywygHORFs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=UHbkVutPokFzw/Ir09i0z06gK1v3Ue3LA0vi6xM+U3Cn+sTtyBYt5JmtnVr6mMIES
	 dqXCDu3iYyf/aDPkrDMCOAu7gpX6go/EMrvA05Zjt2ggcZt3DEFhlu34TxTT4taIh+
	 XMF7YAj/caMWodNRHEqMX1jpADkoZxYtQq0uoJb7JxTHjtjUVtgBFXK84brDwCIonN
	 i+G7DfX1/Riel2AlObXIND4/fJYmVADh/WQy6xikD75bBq0TjOTQC4tycnOgWbkQFi
	 NY+kMapsRZqRefkVUNHbkN7uXyCxZPmUjoLIRnwbZ75DiK3W73x7ATJ29rJzJmj0d/
	 PY0XO3dqiK4XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8130380AA66;
	Wed, 29 Jan 2025 19:50:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 29 Jan 2025 19:50:30 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: benoit.gschwind@minesparis.psl.eu, cel@kernel.org, herzog@phys.ethz.ch, 
 baptiste.pellegrin@ac-grenoble.fr, jlayton@kernel.org, anna@kernel.org, 
 harald.dunkel@aixigo.com, tom@talpey.com, trondmy@kernel.org, 
 carnil@debian.org, chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Message-ID: <20250129-b219710c26-8889e93df099@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

Looking further back in trace.dat:

  kworker/u194:9-1629754 [033] 309447.521022: nfsd_cb_free_slot:    task:00001fa3@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 new slot seqno=8100
  kworker/u193:6-1630755 [004] 309468.053064: nfsd_cb_seq_status:   task:00001fa4@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=0 seq_status=0
  kworker/u193:6-1630755 [004] 309468.053066: nfsd_cb_free_slot:    task:00001fa4@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 new slot seqno=8101
 kworker/u194:13-1634037 [013] 309549.519294: nfsd_cb_seq_status:   task:00001fa5@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=-5 seq_status=1
 kworker/u194:13-1634037 [037] 309558.734930: nfsd_cb_seq_status:   task:00001fa6@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=-5 seq_status=1
  kworker/u194:0-1662968 [047] 309567.950612: nfsd_cb_seq_status:   task:00001fa7@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=-5 seq_status=1
 kworker/u194:13-1634037 [043] 309577.167133: nfsd_cb_seq_status:   task:00001fa8@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=-5 seq_status=1
 kworker/u193:14-1658519 [008] 309586.381715: nfsd_cb_seq_status:   task:00001fa9@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=-5 seq_status=1
  kworker/u194:6-1659115 [045] 309588.599171: nfsd_cb_seq_status:   task:00001faa@0000009a sessionid=67952a7d:4dd6ab1d:00000fb0:00000000 tk_status=-512 seq_status=1

(Not shown here) this is a CB_RECALL_ANY operation that was sent several times but timed out. The retry mechanism could have dropped this operation after the first timeout, or it could have noticed that the callback transport was marked FAULT.

This situation appears to resolve itself.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c26
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


