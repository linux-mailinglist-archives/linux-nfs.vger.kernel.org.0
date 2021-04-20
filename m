Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF936602D
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhDTT2T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 15:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233741AbhDTT2R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 15:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618946865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkDf0Lno9ADDSNoaWNa1vN1CGzzYutPuKrV1VJbTN+M=;
        b=WefgiotJzXmMbP1xL0wyfK+byq5lcrRhiP8Tfe9lIe6nqcW1ieSibn0GyGzqtJHBX7Llu8
        +NQRGPq2KcvUrLeWyvztxz51CEXAsKRzLvF/6/QfErjML5aAJvY5Q7KcS1Wisvs2PUs4AC
        UJRb16W2O9wmo4BPjttroL+J9vyBpQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-RsAKQWC2OEq6zO_PK6dv6w-1; Tue, 20 Apr 2021 15:27:43 -0400
X-MC-Unique: RsAKQWC2OEq6zO_PK6dv6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C175D18BA283;
        Tue, 20 Apr 2021 19:27:41 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-232.phx2.redhat.com [10.3.113.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC76310016DB;
        Tue, 20 Apr 2021 19:27:40 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
 <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
 <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
 <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
 <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
 <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
 <20210420171806.GC4017@fieldses.org>
 <be1a2b6beab29b3e40277f5fefd6c49b37c32361.camel@hammerspace.com>
 <20210420174036.GD4017@fieldses.org>
 <85b4ca155d1697a714be88a67c505d287e22be46.camel@hammerspace.com>
 <20210420181627.GA7297@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <ed3c0acc-aeab-bd9f-69d4-82b2fed5d949@RedHat.com>
Date:   Tue, 20 Apr 2021 15:30:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420181627.GA7297@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/20/21 2:16 PM, bfields@fieldses.org wrote:
> On Tue, Apr 20, 2021 at 05:53:34PM +0000, Trond Myklebust wrote:
>> So if the machine-id exists, then maybe we could indeed generate the
>> identity using the uuid in that file (although the question remains as
>> to why you'd want that?).
> 
> I was assuming: When you clone a machine image, either you want the
> clone to have the same identity (maybe it's a backup, or you're doing
> some sort of migration) or you want it to act like a new machine (say
> you've got a base image that you're using to make a bunch of hosts).  In
> the latter case you've got to track down everything on the filesystem
> that needs to differ between hosts and fix it up.  The fewer of those,
> the better.
For the record... I cloned a VM and the /etc/machine-id were the same.
The later would have to happen. 

> 
>> However the generated value should then be persisted separately so
>> that it can be platform independent.
> 
> That'd be OK.
> 
> I don't think switching a host between systemd and not systemd-based is
> a common case.
> 
> If somebody has a really weird case they can always write their own
> script.
+1 

steved.

