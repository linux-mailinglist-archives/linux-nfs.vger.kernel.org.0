Return-Path: <linux-nfs+bounces-22817-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1GF5HSo1PGoZlQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22817-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:51:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB56C119B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:51:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=CRNrNFei;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22817-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22817-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAABF301092A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E03CAE8F;
	Wed, 24 Jun 2026 19:51:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4545305E28
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 19:51:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330663; cv=none; b=CiaqCcvhgkvrHw/44gCYCXPh4QKzEP2944HJuiWPeisJVkQFfYDIeS5TPEQ/7AvmYnZGSpYGbg9K/4QjjcI4d3awEK2Qgfi2OWD9UsSf2zwuqH9JBA+aTOtfqIg79/x/ygBbvQ7d+Co9814KYIqOKlqfXrY6zFAVDySsAtPn4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330663; c=relaxed/simple;
	bh=RpFNhR9MSaaukTeN19oFg0XhCidk+CdrStM2Q1qchf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoaY+RquKQ0iez73au2wDVEDgG7/mBtV5qahJXHzPyQ0XaJiEO8zI96NsopKRgYGpvEsfk0HJpDuG2rV48H06Tf9Gr9w6fu92tkmxTcPq+s41tppLIiEun9jcBWOGuZ9aTZc6ZEUBNWa+x7exxYCswv3gltWd6bgh+cHiPOhJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CRNrNFei; arc=none smtp.client-ip=209.85.160.54
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-447bb8bb754so199180fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782330660; x=1782935460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oir73IMSmj+bwoGW/7+1aP++xNenKOd4gZDFr6n1WbQ=;
        b=CRNrNFeiCNZypSVeQ2jp/Vg7yhV7Di7oqQm8mnUV0BM6ZdPuUI+iVpcc2v/GD4WwW6
         bAst7JBes7k5IuMda/DoJJltYYwcu09SJ7P52X4xz53j8M/UL8ST5ZL8BIUahW41v9de
         1uYj2E6+LOb6QRC1N17Jacjt3JwXWPh5l1eq+Q4Pf+qpdGPb7UguzunBrbgCObwylrmZ
         nOS2KmvZrzxqvRyw9tEXTJfzuB5CQetCWYft1vEMmGBzsWnf++JHax8WKdXyMBPmtIkj
         DxKmsa70Fzs0Ige0iUN3Kd4xWR0KvihtdmhRyFKdhi+vwn6W12joNiQacNSnZLV+8Aii
         HExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330660; x=1782935460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oir73IMSmj+bwoGW/7+1aP++xNenKOd4gZDFr6n1WbQ=;
        b=c4fRs4ozKsObFWRLE2hWdzMI9RM8IgNTzKi0/aBMNwAZjCbopajf87MP8uAXqrpCW4
         /EFnFcJgbFa79kd8x38Ts6shHiKN1DxN0vhy90RxIsVX1tuVBQ22TxjWMBdL6FJwxnhh
         PdNnCQg4iA2mKY5dJ/xsxbaje2sz0PIFYZsVRoV+R2evtADBes47ACltxSrHv7exfkVm
         WhbFo3MWOSMiSk5jfe1smbksWf4jhvsfQSnfrQV1FFswSz35nYmjiowV3yFelP6hFEKf
         g+run+ORDuie+llPgxtIvXTV+SY0xCUuk82+yxt6FBLejmTiuZzhIXT9g+nuOj1prPmj
         x+4A==
X-Gm-Message-State: AOJu0Yz9GMA1CxV0KdnbJBrY5vJkeKlyWVbaZHj2ENd4/T6SKj1WOggs
	ok3tI9B9w6mpB6B6h0uNRStJ0XPB26/iByg5tLvWeuAfufrYDKq0YGDwD/VYgMl8lpi87gA5TZ+
	T8ZQA
X-Gm-Gg: AfdE7ckChwr1ErDXrclgt5o23cM3L87rv9/QHpclN6c81YSVj44ms0Fa8u3eQ+3bIiO
	UxvmvMjU6YMYY02j9as8h/BAjKmtRsyRSexuyO1M9WzLtDqDRpRNFqh76aHdJ+YhEuqrXZDtZZ8
	zIsNY7f1qwrN7+mgr2GFNsPf2od08HDBt8NVDizarQa9R6zguQeiIo3iLzp8IZQFpCDMiK/xxp7
	goQTJr7APf0goNdYCIRllNrniuF6zWD8HrxdxJGW3SPYOqwKG+9fWJgGvIxokCndjhL1l9jSCVD
	/fvJsGi4MjeqtcENhYD4bmJnrEz7VlLBBpvxZhejyDCDxdnxJaVt6RAK6Kx2O8E0KPdttdr+3Z7
	OAelQc6llqgD5KabAiPHOFuPUnGq46eeRxh76Wq68MRyBXv2GpZEq972HXmJS0aoVtZHSZrLyyY
	Cbf8dZFPJs5UL8bhfuNCZDk/udi3K0SPe7g9N7icBRVxrxiSyvIQaE7dvD/0s=
X-Received: by 2002:a05:6820:1c94:b0:69d:ecb9:4a2 with SMTP id 006d021491bc7-6a12d788b4dmr1083675eaf.4.1782330660464;
        Wed, 24 Jun 2026 12:51:00 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a11e6ef161sm2902890eaf.5.2026.06.24.12.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:51:00 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] pNFS/flexfiles: honor clora_changed and report cancelled I/O
Date: Wed, 24 Jun 2026 15:50:55 -0400
Message-ID: <cover.1782329389.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22817-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,hammerspace.com:dkim,hammerspace.com:mid,hammerspace.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CAB56C119B

RFC 8881 section 20.3.3 lets CB_LAYOUTRECALL carry clora_changed: when it
is FALSE the client may flush modified data to the data servers before
returning the layout; only when it is TRUE should it stop writing to the
DS and redirect through the MDS.  The client decodes cbl_layoutchanged but
has ignored it since commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if
the layout is recalled or revoked"), cancelling in-flight DS I/O
unconditionally -- which can leave a write incomplete at the DS with no
write layout held.

This series teaches the client to honor clora_changed: on an unchanged
recall it drains its in-flight DS writes before LAYOUTRETURN instead of
cancelling them; when it does cancel (changed recall, or revoke) the
cancelled I/O is reported to the server as NFS4ERR_NXIO so it can
reconcile the affected mirror instance.  Patch 1 adds clora_changed to the
recall tracepoint.

Based on v7.1.

Benjamin Coddington (3):
  pNFS: report clora_changed in the cb_layoutrecall_file tracepoint
  pNFS: honor clora_changed when recalling a layout
  NFSv4/flexfiles: report cancelled I/O as a layout error

 fs/nfs/callback_proc.c                 |  5 ++-
 fs/nfs/flexfilelayout/flexfilelayout.c | 23 ++++++++++-
 fs/nfs/nfs4trace.h                     | 55 +++++++++++++++++++++++++-
 fs/nfs/pnfs.c                          | 21 +++++-----
 fs/nfs/pnfs.h                          |  2 +-
 5 files changed, 92 insertions(+), 14 deletions(-)

-- 
2.53.0


