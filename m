Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5F286676
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgJGSEa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 14:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbgJGSEa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 14:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602093869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlivSjr5guvvsAqmB5ZI0Baghmq2/7/3ZahJX1asutM=;
        b=cWTG1IenKbIxoByyBP7YmR+JVcS4DK+fTiGl3sTzANMtGZJwmGZ1q5KrwODhTBz4qzLlGX
        CcKThEtxNguq98x99tzSeoK6JhlbWzO2//uLDwVBn8pEhItT1FkKvGHOX0/84W9hMelm2q
        6HmVNLX557viCL8AXO5eM9u2HU5UAPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366--90aCHGIOSWkU640NnfDzQ-1; Wed, 07 Oct 2020 14:04:27 -0400
X-MC-Unique: -90aCHGIOSWkU640NnfDzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 414009CC12;
        Wed,  7 Oct 2020 18:04:26 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 674AC5DE82;
        Wed,  7 Oct 2020 18:04:25 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@gmail.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <aglo@umich.edu>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Date:   Wed, 07 Oct 2020 14:04:24 -0400
Message-ID: <7755CA77-7ABB-438A-A6E1-C3A73A54B7B3@redhat.com>
In-Reply-To: <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
References: <20201006151335.GB28306@fieldses.org>
 <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Oct 2020, at 12:44, Trond Myklebust wrote:
> I did see Igor's claim that there is a QoS issue (which afaics would
> also affect NFSv3), but why do I care about QoS as a per-mountpoint
> feature?

Because it's hard to do QoS without being able to classify the traffic on
the network somehow.  The separate connection makes it a lot easier.  I see
how that's - not our problem -, though.

The regular admin might find it surprising to tell their system to
connect to a specific IP address at mount time, and it instead sends the
mount's traffic elsewhere.

Are you happy with the state of nconnect, or is there room for something
more dynamic?

Ben

