Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127A61B7DF2
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXSjR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 14:39:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726813AbgDXSjQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 14:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587753555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IOqFvwfKmEda6V8gLlVYTG2QujKigDRrJG8pAG7ofyk=;
        b=TdKm3eEyOyERkCVED29MGzrQnf88eYi4bqihkrQihzNiC5nXJH6+BnSAd1pg2DbChhfNWI
        BTSbTBygjECG/N2uUnsGWchx3WHbyW875sz96ShzanySBelFhFHBU6p8ACsW07csl8k4LT
        /YswqoOJ3aCQCShNfNWkVzNCpFf35FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-RkTjPBBrOZenycjZX-lWHQ-1; Fri, 24 Apr 2020 14:39:14 -0400
X-MC-Unique: RkTjPBBrOZenycjZX-lWHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39BDA100CCE9
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-114-147.phx2.redhat.com [10.3.114.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 001F219629
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 18:39:12 +0000 (UTC)
From:   Tom Stellard <tstellar@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: Warnings fixes for building with clang
Date:   Fri, 24 Apr 2020 18:39:04 +0000
Message-Id: <20200424183906.119687-1-tstellar@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Here are a few patches to fix warnings caught while building with clang.

-Tom


