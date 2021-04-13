Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7599B35E2FE
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDMPgQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 11:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhDMPgP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 11:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618328155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjR6dQcP9PiLW96H12ODFF5rpWmc3lnG55Quqk8W1Yk=;
        b=JuUc1iwfaCzLA4BobiTv4pShlw4aa7ew+hmXX2t2TuG4iTBB27A3xEd+BRXtiPMkPgyTq5
        Wt8Og0TuG4zjejOQkro/IXxXVp/GwFwf5+CQLU1aZzSLce7O3/yyjYG1doTEV6RJPsOSQ4
        hh0eidPrS5Dt3oud/YEu1KV8cIP1M4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-xykiyZe_OrGoCEG5CKr_0Q-1; Tue, 13 Apr 2021 11:35:53 -0400
X-MC-Unique: xykiyZe_OrGoCEG5CKr_0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45C7488127C;
        Tue, 13 Apr 2021 15:35:52 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D36716A034;
        Tue, 13 Apr 2021 15:35:51 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     hedrick@rutgers.edu
Cc:     "Patrick Goetz" <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
Subject: Re: safe versions of NFS
Date:   Tue, 13 Apr 2021 11:35:50 -0400
Message-ID: <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
In-Reply-To: <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It would be interesting to know why your clients are failing to reclaim 
their locks.  Something is misconfigured.  What server are you using, 
and is there anything fancy on the server-side (like HA)?  Is it 
possible that you have clients with the same nfs4_unique_id?

Ben

On 13 Apr 2021, at 11:17, hedrick@rutgers.edu wrote:

> many, though not all, of the problems are “lock reclaim failed”.
>
>> On Apr 13, 2021, at 10:52 AM, Patrick Goetz <pgoetz@math.utexas.edu> 
>> wrote:
>>
>> I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 servers 
>> and haven't had any problems.
>>
>> Check your configuration files; the last time I experienced something 
>> like this it's because I inadvertently used the same fsid on two 
>> different exports. Also recommend exporting top level directories 
>> only.  Bind mount everything you want to export into /srv/nfs and 
>> only export those directories. According to Bruce F. this doesn't buy 
>> you any security (I still don't understand why), but it makes for a 
>> cleaner system configuration.
>>
>> On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
>>> I am in charge of a large computer science dept computing 
>>> infrastructure. We have a variety of student and develo9pment users. 
>>> If there are problems we’ll see them.
>>> We use an Ubuntu 20 server, with NVMe storage.
>>> I’ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.0. We 
>>> had hangs with NFS 4.1 and 4.2. Files would appear to be locked, 
>>> although eventually the lock would time out. It’s too soon to be 
>>> sure that moving back to NFS 4.0 will fix it. Next is either NFS 3 
>>> or disabling delegations on the server.
>>> Are there known versions of NFS that are safe to use in production 
>>> for various kernel versions? The one we’re most interested in is 
>>> Ubuntu 20, which can be anything from 5.4 to 5.8.

