Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F71B0E7F
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgDTOfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 10:35:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726895AbgDTOfr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587393345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MqMi0H8yFIC5LGLaft5IZtVsook5qMLLxsRrvWbljdU=;
        b=V1yo8mS5kUjfw/z7YTkrERG7PPWTpwF7Vk4vlqpd4+fNl+4jQyR7M96mmvdtdDw4KrCScc
        0Dn7nQQ5mUsjSSFlol8x9UuhCTdDmoKgCbnxD99nDfSnkvraPEZHjM+VDnTq/RGGpoG3c6
        dAsyjyZcBu2IYNcdrKqsUdCM4PdO6yU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-wQw9BnfEMsWB3ne3PhHYog-1; Mon, 20 Apr 2020 10:35:41 -0400
X-MC-Unique: wQw9BnfEMsWB3ne3PhHYog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE6B7802567;
        Mon, 20 Apr 2020 14:35:40 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-102.phx2.redhat.com [10.3.114.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66ACF16D22;
        Mon, 20 Apr 2020 14:35:40 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 5BB54120239; Mon, 20 Apr 2020 10:35:39 -0400 (EDT)
Date:   Mon, 20 Apr 2020 10:35:39 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        "mora@netapp.com" <mora@netapp.com>
Subject: Re: about nfscache problem
Message-ID: <20200420143539.GA102318@pick.fieldses.org>
References: <7610f9108e1342258c25b3bc72c92a67@G08CNEXMBPEKD05.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7610f9108e1342258c25b3bc72c92a67@G08CNEXMBPEKD05.g08.fujitsu.local>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 20, 2020 at 08:13:51AM +0000, Su, Yanjun wrote:
> At this time, the nfscache problem has not progressed for long time. Do we still need to follow it?
> 
> The problem is as below
> The test commandline is as below:
> ./nfstest_cache --nfsversion=4 -e /nfsroot --server 192.168.102.143
> --client 192.168.102.142 --runtest acregmax_data --verbose all
> 
> More detail info is here:
> https://linuxlists.cc/l/17/linux-nfs/t/3063683/(patch)_cache:_fix_test_script_as_delegation_being_introduced
> 
> This patch adds compatible code for nfsv3 and nfsv4.
> When we test nfsv4, just use 'chmod' to recall delegation, then
> run the test. As 'chmod' will modify atime, so use 'noatime' mount option.
> 
> After a discusion with you, a chmod is a reliable way to recall delegations.
>
> Can you contact mora and make a decision for it?

I don't have any better way to contact him than the address cc'd above.

Remind me what the problem is?  How is the test failing?

--b.

