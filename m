Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5167360F09
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhDOPbz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 11:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhDOPbz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 11:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618500691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KC5geY5UObvuIHXGEGiZShF25CiZByUekR708lhDX/4=;
        b=HUfIlhBcjnOSCSRloqvorn1vLFWI4G9rogJg3S7S+jgjodfoyVFK8wCcqu5asWyGhr554D
        x1g17kUpPas+3SHZq6f7xZGwz/uKihp00gA8V12CR+sRMV9Yqh8ub+5VgoQETvi7DylYJP
        SmnYVDqeJlLXMIOjhTvvdjtT4FYANYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-4MJD84vxOm60BdV_ttIgpw-1; Thu, 15 Apr 2021 11:31:10 -0400
X-MC-Unique: 4MJD84vxOm60BdV_ttIgpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC486801814;
        Thu, 15 Apr 2021 15:31:09 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 720635D723;
        Thu, 15 Apr 2021 15:31:09 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
Date:   Thu, 15 Apr 2021 11:33:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Chuck! 

On 4/14/21 7:26 PM, Chuck Lever III wrote:
> Hi Steve-
> 
>> On Apr 14, 2021, at 2:10 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>
>> ﻿This is a tweak of the patch set Alice Mitchell posted last July [1].
> 
> That approach was dropped last July because it is not container-aware.
> It should be simple for someone to write a udev script that uses the
> existing sysfs API that can update nfs4_client_id in a namespace. I
> would prefer the sysfs/udev approach for setting nfs4_client_id,
> since it is container-aware and makes this setting completely
> automatic (zero touch).
As I said in in my cover letter, I see this more as introduction of
a mechanism more than a way to set the unique id. The mechanism being
a way to set kernel module params from nfs.conf. The setting of
the id is just a side effect... 

Why spread out the NFS configuration?  Why not
just keep it in one place... aka nfs.conf?

Plus we could document all the kernel params in nfs.conf
and the nfs.conf man page. The only documentation I know 
of is in the kernel tree.

As far as not being container-aware... that might true
but it does not mean its not useful to set the id from
nfs.conf... Actual I have customers asking for this type
of functionality

steved.
> 
> 
>> It enables the setting of the nfs4_unique_id kernel module 
>> parameter from /etc/nfs.conf.
> 
>> Things I tweaked:
>>
>>    * Introduce a new [kernel] section in nfs.conf which only
>>      contains the nfs4_unique_id setting... For now... 
>>
>>    * nfs4_unique_id can be set to two different values
>>
>>        - nfs4_unique_id = ${machine-id} will use /etc/machine-id
>>            as the unique id.
>>        - nfs4_unique_id = ${hostname} will use the system's hostname
>>            as the unique id.
>>
>>    * The new nfs-config systemd service need to be enabled for the
>>      /etc/modprobe.d/nfs.conf file to be created with 
>>      the "options nfs nfs4_unique_id=" set. 
>>
>> I see this patch set is not a way to set the nfs4_unique_id 
>> module parameter... I see it as a beginning of a way to set 
>> all module parameters from /etc/nfs.conf, which I think
>> is a good thing... 
>>
>> [1] https://www.spinics.net/lists/linux-nfs/msg78658.html
>>
>> Alice Mitchell (3):
>>  nfs-utils: Enable the retrieval of raw config settings without
>>    expansion
>>  nfs-utils: Add support for further ${variable} expansions in nfs.conf
>>  nfs-utils: Update nfs4_unique_id module parameter from the nfs.conf
>>    value
>>
>> configure.ac                  |   1 +
>> nfs.conf                      |   4 +-
>> support/include/conffile.h    |   1 +
>> support/nfs/conffile.c        | 283 ++++++++++++++++++++++++++++++++--
>> systemd/Makefile.am           |   3 +
>> systemd/nfs-client.target     |   3 +
>> systemd/nfs-conf-export.sh    |  28 ++++
>> systemd/nfs-config.service.in |  18 +++
>> systemd/nfs.conf.man          |  19 ++-
>> tools/nfsconf/nfsconf.man     |  10 +-
>> tools/nfsconf/nfsconfcli.c    |  22 ++-
>> 11 files changed, 372 insertions(+), 20 deletions(-)
>> create mode 100755 systemd/nfs-conf-export.sh
>> create mode 100644 systemd/nfs-config.service.in
>>
>> -- 
>> 2.30.2
>>

