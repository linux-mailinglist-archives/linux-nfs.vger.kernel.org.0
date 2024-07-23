Return-Path: <linux-nfs+bounces-5015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91293A11D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 15:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E09283D4E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA2152DF7;
	Tue, 23 Jul 2024 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="QFIEbTCy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04B152799
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740601; cv=pass; b=Tl0coIQUc8w2pw94v1Tg0itCYNxnjPutLY4OnaaiK4D2LfCzydFOJDUN5O5Au9V0oyHtLyRWJJ6gOlGoDHAK9x0Hw5CR08h0UkEeWBwghaO5JyGusW/arPUrOqD/87GvA1ZWBF7jjajkcx8bcRj/XLDt32VuY4kjpEGLMGdHwgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740601; c=relaxed/simple;
	bh=cDsDfh4FfE/o/bEz2PLwUiUsRVscYusaORlJmMsndSo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HF/7B3b8oQ0FHXeV0BvFS8Ws51bor9jR25Dc0J9c3PiJr7PhLDBvng6WqE2XJmC1442LZosMjR7VaPrvZcOR5lhzPWgacI15004ctpvJZHrSc7oMXnAxrEFV+pd82PygztxiGs0rf044GplNzs9TVI20QGOa/7aLVPyW3XhdU7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=QFIEbTCy; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 34B5E365F99
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 13:16:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A7392365195
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 13:16:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1721740598; a=rsa-sha256;
	cv=none;
	b=Zhc/XSyrJpXzJEh9yehRqkYQHOMUMS6RZLfIOuzrXXnh3ZfDaDaaXabOesYLdB9aROQyUB
	4UO9DiaXHzE+94w8oF+xPy8PKXw5jdM08CQpv4HDurrCswXNynz84z/BfqVNetlBQNMsgs
	ER+G0q4J+XYwhw5qT+VPIpy6lpJpa5IAxFiBdJG9TmF9WzYMUfIJ9HZvBZv46EB+4YaIud
	1ylvEbmsPlKIAIIysJ6f7l76hOpUmpyyNU9RQmcOKvauKdD8EJYGkaL3+H4RsEUgqf9mf7
	DjmjY44bDDQXCMOXeNk2UX8KzFHMLKoTQ/qHHITtt0ZA/mCWcdXKhKq0nldWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1721740598;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:dkim-signature;
	bh=9l91go5wPK7kQ/kvneJOiWbTYnB3hbpUXyrIyRuhQj4=;
	b=F45J0FCV69HNZ6Idx+A1xNJxLr16DvL94uOl12SI+8v3zEfkTw/H+DfxMFw1X3yidiS21t
	tKXRm49dWvZbSkcTsfVahC4n/ifmWPcQ52uvCcQkssPF/kYG4bhPqneXCm12kAVpii/DYy
	glR2KyaIAiQm6ue65urzwwzacoktlLCQe/j/1Ni28PtnG7bCO9UEAAG23ET6IPEeByykdu
	142MdTX6oSdmH92A/GkuAzBELuzHNMg30tJApD4OZ78QFFfrxtms1wtzo/CNxKIf/x+bf0
	DqfzqdDZQd+kgYyHvewrqbhCjLInGy+wyaa/9dJyKwPvbmp21LyupXE6I+Chtw==
ARC-Authentication-Results: i=1;
	rspamd-587dc898b6-59lbj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Name: 16a4331b5f05d2ca_1721740598941_1275429556
X-MC-Loop-Signature: 1721740598941:2495758973
X-MC-Ingress-Time: 1721740598941
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.180.92 (trex/7.0.2);
	Tue, 23 Jul 2024 13:16:38 +0000
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4WSyN643RfzK4
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1721740598;
	bh=9l91go5wPK7kQ/kvneJOiWbTYnB3hbpUXyrIyRuhQj4=;
	h=Reply-To:From:Date:Subject:To:Content-Type;
	b=QFIEbTCy9HE7IS+H795zF7jT4LGEhR3wQ8qEKsLQXoGSwzlqRZnW7OIjq3yxhQie0
	 6PXsDQVCpQLUve5JZtL/THB0+Styary9zW7zd65HX7DKMbHsorLNmtPEnVafHDrSFA
	 4oO+Ic2EBfV0KaD0CrfagAXEI4+ggXsHc4Z3732WISFizi0Y9rwoSqWE12zZ+6e9jT
	 eREzByi6jjgZzHFGxfhkcJxQovXe7ROQp/Uh9SBu9k4UXDn6DyHDDd212ZJ0GsDTpQ
	 7NANCFhQ84dWtqFCQiMawNg1c257MGO7pCa0FrgMO7xrSFMlky55f5Zv0Vyn6h5oTX
	 Ok4QPerCMDH/A==
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8036ce66134so214415939f.3
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 06:16:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx3jtFd3ZHg1GWtMZvBVhyP/anNZwWac3IrQ3G/izVsjp1RoJkm
	C2t2rMgeGMFw8HapEp5KNitVEi7lN0pGy2o4YlTT6iGJAA+Xee/QsUhrJpbYCm28vDE4UUvJdbv
	+QgswpIGUBBaXhCL3yQKwm7xufPY=
X-Google-Smtp-Source: AGHT+IFb1s97AREixdUuIPbwJKFTkHGorcpPUbO2eqypOrjudh4Ig7j3ZxXJTz9GzzqTkgyeIApia5QeQiO2RehXe00=
X-Received: by 2002:a05:6602:160d:b0:7f9:217c:c109 with SMTP id
 ca18e2360f4ac-81ea3c2eff4mr354756039f.9.1721740597830; Tue, 23 Jul 2024
 06:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: gisburn@nrubsig.org
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Tue, 23 Jul 2024 15:16:12 +0200
X-Gmail-Original-Message-ID: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
Message-ID: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
Subject: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hi!

----

[2nd attempt to send this email]
The Win32 API has |FILE_ATTRIBUTE_TEMPORARY| (see
https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea)
to optimise for short-lived/small temporary files - would it be useful
to reflect that in the NFSv4.2 protocol via a |FATTR4_TMPFILE|
attribute (sort of the opposite of |FATTR4_OFFLINE|, such a
|FATTR4_TMPFILE| should be ignored by HSM, and flushing to stable
storage should be relaxed/delayed as long as possible) ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

