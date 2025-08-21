Return-Path: <linux-nfs+bounces-13815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A35B2F650
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D37DAC2706
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98B330E83E;
	Thu, 21 Aug 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2v0I8T/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204D30E846
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774934; cv=none; b=GmiHWqOvEmwHhEj9HYgdhh6Tvjk/TrtKtxZtSX2kGEUFkQsO8gnMsBLY1ZKzX7aOjlE8cruXH/+iZlQn+mxPZL8isTldOECOC1Tlfn9JBFQHqj+Dg5QgaEXwIdEtK3oMXaUV7YJu7k+g68Kok9UuEpSX+1NmlNOsu4KEttKU/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774934; c=relaxed/simple;
	bh=ga/vKUanVg5dBxx8Xee0tIlWpfoEkOS/4u+L/O28Q/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMZWcmFveXNTs04ObojGMxp5jyAETprHmdMvKvA/gFtjag1GITT0Vr19eujwbXpEy30213yzolt6PLEzvLRIeCm9Tla3/0JChT83t7QuIGi88I4cp66VUF+bIPoC+n/cGRJHC2VTWSVR9+lTZ5Ms0ESfKvA1mwYeog2WXMIDI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2v0I8T/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iE5KY/4yjIcIu0yghICx/YPOVFhKpfX9E+oT5UA9wdo=;
	b=f2v0I8T/6WmptgTSwq8xsAMCgy4tE409BBz/UYiRm5rlORFkA1kTyUoiEx1nwHO3AK1U8D
	FnRLfiEmNkFkFs/FtRRHzYHQ5OPsoOVQfUPk/+7qwVbMqwBar7biUuCsf++nWoEl+XC+Wp
	Ht18qAaqG2ZYzPdzAfYkSNwuD+j45SA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-40IQMPG4O_ifbu0Z6kadEg-1; Thu,
 21 Aug 2025 07:15:28 -0400
X-MC-Unique: 40IQMPG4O_ifbu0Z6kadEg-1
X-Mimecast-MFC-AGG-ID: 40IQMPG4O_ifbu0Z6kadEg_1755774927
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7254519560AD;
	Thu, 21 Aug 2025 11:15:27 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C3261955F24;
	Thu, 21 Aug 2025 11:15:26 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 00/12] Convert old-style function definitions into modern-style definitions 
Date: Thu, 21 Aug 2025 07:15:11 -0400
Message-ID: <20250821111524.1379577-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch set converts all of the old-style function definitions
into modern-style definitions through out the library... 
basically touching almost every function definition.

The conversion was pretty straightforward... The same 
repetitive changes were make on all the functions
and the compiler pointed out any declaration issue
that came up. I'm confident the API did not change.

I test the changes by doing kernel builds over both
secured and unsecured mounts. I also ran my Bakeathon 
Cthon tool which mounts all versions, simultaneously, 
and runs cthon test on them... both secured and
insecure mounts... for over 48hrs.

The one part I didn't test was the NIS support
since I didn't have a NIS setup... I'm pretty
confident things should work... Again the
changes were I'm all straightforward.

Reviews are welcome!

Steve Dickson (12):
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions
  Convert old-style function definitions into modern-style definitions

 src/auth_time.c     |  42 +++---
 src/auth_unix.c     |  29 ++---
 src/authunix_prot.c |   4 +-
 src/bindresvport.c  |   4 +-
 src/clnt_bcast.c    |  46 ++++---
 src/clnt_dg.c       |  59 ++++-----
 src/clnt_perror.c   |  23 +---
 src/clnt_raw.c      |  46 +++----
 src/clnt_simple.c   |  19 +--
 src/clnt_vc.c       |  75 +++++------
 src/getnetconfig.c  |  24 ++--
 src/getnetpath.c    |  12 +-
 src/getpublickey.c  |  20 +--
 src/getrpcport.c    |   8 +-
 src/key_call.c      |  58 ++++-----
 src/netname.c       |  19 ++-
 src/netnamer.c      |  31 ++---
 src/pmap_getmaps.c  |   3 +-
 src/pmap_getport.c  |  10 +-
 src/pmap_prot.c     |   4 +-
 src/pmap_prot2.c    |   8 +-
 src/pmap_rmt.c      |  31 +++--
 src/rpc_callmsg.c   |   4 +-
 src/rpc_generic.c   |  31 ++---
 src/rpc_prot.c      |  36 ++---
 src/rpc_soc.c       | 310 ++++++++++++++++++++++----------------------
 src/rpcb_clnt.c     | 154 +++++++++++-----------
 src/rpcb_prot.c     |  48 +++----
 src/rpcb_st_xdr.c   |  42 +++---
 src/rpcdname.c      |   3 +-
 src/rtime.c         |  11 +-
 src/svc.c           | 107 +++++++--------
 src/svc_auth.c      |  14 +-
 src/svc_auth_unix.c |  12 +-
 src/svc_dg.c        |  75 +++++------
 src/svc_generic.c   |  32 ++---
 src/svc_raw.c       |  46 ++++---
 src/svc_simple.c    |  19 ++-
 src/svc_vc.c        | 111 ++++++++--------
 src/xdr.c           | 224 ++++++++++++++++----------------
 src/xdr_array.c     |  26 ++--
 src/xdr_float.c     |  12 +-
 src/xdr_mem.c       |  74 +++++------
 src/xdr_rec.c       | 121 ++++++++---------
 src/xdr_reference.c |  20 +--
 src/xdr_sizeof.c    |  30 ++---
 src/xdr_stdio.c     |  54 ++++----
 47 files changed, 1032 insertions(+), 1159 deletions(-)

-- 
2.50.1


