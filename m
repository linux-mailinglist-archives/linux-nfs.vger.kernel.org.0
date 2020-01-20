Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C142F0A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgATPwd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jan 2020 10:52:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbgATPwd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jan 2020 10:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579535552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FaMYkSx/3KkELVaNoOiDXv8BsOhyl+zQGF10fBlEdE=;
        b=h8STAr/vmnnSU98A+FvQValUwi7xBFmLd1xwsQQwCJd9LIwIyJ+yCWMgkeOCLPYCel2Kai
        uS0qtetvz8qnsgwPjLZgiC/gdzc9L9ITx4LRaU7A8lEa/2/Tho0jCoLN+piPVNIUjBvONK
        hsK1ol6tOUFQ+dsl2sWVPF0yC8unkZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-KsB_SO6tN8OBFpTu3-n_oQ-1; Mon, 20 Jan 2020 10:52:30 -0500
X-MC-Unique: KsB_SO6tN8OBFpTu3-n_oQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6BF5107ACCC;
        Mon, 20 Jan 2020 15:52:29 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC7960C05;
        Mon, 20 Jan 2020 15:52:29 +0000 (UTC)
Subject: Re: nfs-utils tag
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <d64033ad7277ce26e328d1b5c7b85050c201beb7.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <1e71f70c-5ce1-9ba7-d3bc-8e96a30f2aa8@RedHat.com>
Date:   Mon, 20 Jan 2020 10:52:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d64033ad7277ce26e328d1b5c7b85050c201beb7.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 1/17/20 9:43 AM, Trond Myklebust wrote:
> Hi Steve
> 
> It looks like the nfs-utils-2-4-3-rc5 tag was modified after it was
> pushed out:
> 
> Fetching origin
> From git://git.linux-nfs.org/projects/steved/nfs-utils
>  ! [rejected]                  nfs-utils-2-4-3-rc5 -> nfs-utils-2-4-3-rc5  (would clobber existing tag)
> error: Could not fetch origin
> 
> 
> Was that intentional? I don't usually do a force-pull of the tags (and
> I suspect most other people do not either) so it is easy to miss that
> tag change.
Yes... I did update the tag... I was wondering if that would cause any problems. :-)

I'm always pushed out tags but I never publish them, like I've started.
I'll try to be a bit more careful in the future... 

steved.

> 
> Cheers
>   Trond
> 

