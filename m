Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C820A2FF2AA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 19:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbhAUR7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 12:59:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389466AbhAUR6v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 12:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611251838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldOFrN+medeAuQ19Km3Q/ag9cNAWn5zQXjM83eZLV2E=;
        b=G2pa8U/DVXT7kbGOtdAdwW2f/dHVb3gyW0hnGPk5QOsVkEhOkEWck/UWvrPqo+Mi4ODgBl
        zzNkY0B20fnWTGuCUp6I2+SvsUY/2yBMu9Qs/3Fs/LnKAqsrJOyVIQaaB4YbLLfCQWQ+Ui
        UvI/VQ1gITeGYdrCHMH9hgY+bN65ijk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-o7NLf_WUNTaTfNhfVsElzg-1; Thu, 21 Jan 2021 12:57:14 -0500
X-MC-Unique: o7NLf_WUNTaTfNhfVsElzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC67715720;
        Thu, 21 Jan 2021 17:57:13 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-130.rdu2.redhat.com [10.10.64.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 722465D9C6;
        Thu, 21 Jan 2021 17:57:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Anna Schumaker" <schumaker.anna@gmail.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 07/10] NFS: Support headless readdir pagecache pages
Date:   Thu, 21 Jan 2021 12:57:12 -0500
Message-ID: <4DE5379B-E52D-4C94-8701-29FEFCE8C438@redhat.com>
In-Reply-To: <CAFX2Jf=Kg+fbxSfgJ_Kzxe6LerQ8RcZu_8AYp2JFF4THDfy8fQ@mail.gmail.com>
References: <cover.1611160120.git.bcodding@redhat.com>
 <7394b4d348d0c92b64cd0fb4fbf74bfa6e676d24.1611160121.git.bcodding@redhat.com>
 <CAFX2Jf=Kg+fbxSfgJ_Kzxe6LerQ8RcZu_8AYp2JFF4THDfy8fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Jan 2021, at 12:24, Anna Schumaker wrote:

> Hi Ben,
>
> On Wed, Jan 20, 2021 at 12:04 PM Benjamin Coddington
> <bcodding@redhat.com> wrote:
>>
>> It is now possible that a reader will resume a directory listing 
>> after an
>> invalidation and fill the rest of the pages with the offset left over 
>> from
>> the last partially-filled page.  These pages will then be recycled 
>> and
>> refilled by the next reader since their alignment is incorrect.
>>
>> Add an index to the nfs_cache_array that will indicate where the next 
>> entry
>> should be filled.  This allows partially-filled pages to have the 
>> best
>> alignment possible.  They are more likely to be useful to readers 
>> that
>> follow.
>>
>> This optimization targets the case when there are multiple processes
>> listing the directory simultaneously.  Often the processes will 
>> collect and
>> block on the same page waiting for a READDIR call to fill the 
>> pagecache.
>> If the pagecache is invalidated, a partially-filled page will usually
>> result.  This partially-filled page can immediately be used by all
>> processes to emit entries rather than having to discard and refill it 
>> for
>> every process.
>>
>> The addition of another integer to struct nfs_cache_array increases 
>> its
>> size to 24 bytes. We do not lose the original capacity of 127 entries 
>> per
>> page.
>
> This patch causes cthon basic test #6 to start failing with unexpected
> dir entries across all NFS versions:
>
>   ./test6: readdir
>   basic tests failed
>       ./test6: (/mnt/test/anna/Connectathon/cthon04) unexpected dir 
> entry 'h'

Ah, yes -- because we /must/ revalidate before using any cached pages.  
I
think this test unlinks files and that would be a breakage.

> Luckily, the next patch seems to resolve this issue. Could they maybe
> be squashed together?

Yes, they should be squashed - I'll do that in another pass.  I'd like 
to
get rid of uncached_readdir() altogether and then send another version.
Thanks for the test!

Ben

