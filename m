Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524521FF9EA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2020 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgFRRJa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jun 2020 13:09:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727822AbgFRRJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jun 2020 13:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592500166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82LvIxgMt4a3zqNgV7GjzYqS2q7vXbFGvluTVqxJ+vU=;
        b=ToWIqQ0WqomHy22sVz99e2WWXMn+00kHZUmk7360qPUAa+Ex0yq1QqrEpb792gGaMK44IA
        CzfZGpx0eyg+CL69HV8cNSMCscHg/QqPrx9PmUFtwQQFH8jw2Zopx3oQl1sFJr2f3yPQou
        rfs5AatJ9tkuoXEDHhTxRxt7d+AZLec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-OLTB9xnNNBO3kxIyWho0cA-1; Thu, 18 Jun 2020 13:09:24 -0400
X-MC-Unique: OLTB9xnNNBO3kxIyWho0cA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD87107ACF4;
        Thu, 18 Jun 2020 17:09:23 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-115-94.phx2.redhat.com [10.3.115.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71D995EDE2;
        Thu, 18 Jun 2020 17:09:23 +0000 (UTC)
Subject: Re: [PATCH v3] mountstats: Adding 'Day, Hour:Min:Sec' to "mountstats
 --nfs" for ease of understanding.
To:     Rohan Sable <rsable@redhat.com>, linux-nfs@vger.kernel.org
Cc:     smayhew@redhat.com, chuck.lever@oracle.com
References: <20200605144835.GA98618@fedora.rsable.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <8daedaf7-e70c-c2dd-8dad-cc26898e6460@RedHat.com>
Date:   Thu, 18 Jun 2020 13:09:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605144835.GA98618@fedora.rsable.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/5/20 10:48 AM, Rohan Sable wrote:
> This patch adds printing of 'Days, Hours:Mins:Sec' like below to --nfs in mountstats :
> NFS mount age : 12 days, 23:59:59
> 
> Signed-off-by: Rohan Sable <rsable@redhat.com>
Committed.... 

steved.
> ---
>  tools/mountstats/mountstats.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index d565385d..014f38a3 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -4,6 +4,7 @@
>  """
>  
>  from __future__ import print_function
> +import datetime as datetime
>  
>  __copyright__ = """
>  Copyright (C) 2005, Chuck Lever <cel@netapp.com>
> @@ -391,6 +392,7 @@ class DeviceData:
>          """Pretty-print the NFS options
>          """
>          print('  NFS mount options: %s' % ','.join(self.__nfs_data['mountoptions']))
> +        print('  NFS mount age: %s' % datetime.timedelta(seconds = self.__nfs_data['age']))
>          print('  NFS server capabilities: %s' % ','.join(self.__nfs_data['servercapabilities']))
>          if 'nfsv4flags' in self.__nfs_data:
>              print('  NFSv4 capability flags: %s' % ','.join(self.__nfs_data['nfsv4flags']))
> 

