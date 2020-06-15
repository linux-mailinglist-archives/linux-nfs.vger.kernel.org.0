Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F721F9AD3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgFOOux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 10:50:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20169 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728304AbgFOOuw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 10:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592232651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TpVjMtECVs4h4/5L1/hV06u0Qvrl5D0MM8zvZ/HINqQ=;
        b=IhIkBOhRguxbRmrXdS9RMKJDDmkamZjAJzFtv6vSXU4KTe+YBGI6GizESLo0yw6jWcRcDd
        uQEDq2ZmFfj/DwumHVmUXC6AmO7A3Bp8loGwUblRKbqdDQRsycvmvostGk6QQMQkCVKI03
        9bvdWALckhsizVISGthx1ZM30cWuHiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-hJQvTLJCPUKltUfRYFWWLg-1; Mon, 15 Jun 2020 10:50:38 -0400
X-MC-Unique: hJQvTLJCPUKltUfRYFWWLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2C17100A8F7;
        Mon, 15 Jun 2020 14:50:37 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-200.rdu2.redhat.com [10.10.118.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F1FE61983;
        Mon, 15 Jun 2020 14:50:37 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id DA423120476; Mon, 15 Jun 2020 10:50:35 -0400 (EDT)
Date:   Mon, 15 Jun 2020 10:50:35 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Elliott Mitchell <ehem+debian@m5p.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported ZFS
 (with acltype=off) (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200615145035.GA214986@pick.fieldses.org>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613184527.GA54221@mattapan.m5p.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 13, 2020 at 11:45:27AM -0700, Elliott Mitchell wrote:
> I disagree with this assessment.  All of the reporters have been using
> ZFS, but this could indicate an absence of testers using other
> filesystems.  We need someone with a NFS server which has a 4.15+ kernel
> and uses a different filesystem which supports ACLs.

Honestly I don't think I currently have a regression test for this so
it's possible I could have missed something upstream.  I haven't seen
any reports, though....

ZFS's ACL implementation is very different from any in-tree
filesystem's, and given limited time, a filesystem with no prospect of
going upstream isn't going to get much attention, so, yes, I'd need to
see a reproducer on xfs or ext4 or something.

--b.

