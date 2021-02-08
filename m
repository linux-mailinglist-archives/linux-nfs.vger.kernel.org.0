Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C033131AA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 13:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhBHMCJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 07:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233320AbhBHMAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Feb 2021 07:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612785522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyYFgudmpEqfNUncK2hypUiQK2O8y584bPbnjQ/d1ZE=;
        b=CRnTSIXVAOPHdnCzrjV8dVyzWJpRMbXFQdb1CXd70+KKg3rCDUBZhEmvQRYppmFbIo+ClY
        SRn30esAeWWIYwpl1ZsctifzwzYvGTybdp7KYb1lafL3XiQuEB3+c6G8JfWxYEXKuHY/8O
        SlAhACtqZERVntnEoTM43ms62Sbtn08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-o0Yc8CeeMiG4I3A1NyfHEA-1; Mon, 08 Feb 2021 06:58:41 -0500
X-MC-Unique: o0Yc8CeeMiG4I3A1NyfHEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D954192CC40;
        Mon,  8 Feb 2021 11:58:40 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BD819D9C;
        Mon,  8 Feb 2021 11:58:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Rue Mohr" <sn0297@sunshine.net>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: nfs kernel server bug
Date:   Mon, 08 Feb 2021 06:58:38 -0500
Message-ID: <5B1E0F4D-F26F-4CB5-858A-E49D0819C864@redhat.com>
In-Reply-To: <602020C9.50705@sunshine.net>
References: <602020C9.50705@sunshine.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Feb 2021, at 12:18, Rue Mohr wrote:

> I'm having an issue where the kernel server is dishing out all zeros 
> for file content being read over NFS. The file byte count is correct.
> Writing files is fine.
> With the same client, a different server works just fine.
>
> I have been trying to pin this down, so far all I know is that the 
> packets from the server actually contain zeros for the file contents.
>
> The troubled server kernel is 5.4.1
>
> Has anyone encountered this or is it just me?

Haven't heard of this before, but sounds like a fascinating problem.

What version of nfs, and what security?  You're seeing READ operations 
returning
with rsize-ed blocks of all-zero data in a network capture?

Ben

