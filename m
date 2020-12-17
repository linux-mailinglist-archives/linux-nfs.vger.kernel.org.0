Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6E2DD3D4
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 16:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLQPL4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Dec 2020 10:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbgLQPL4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Dec 2020 10:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608217830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1rDDxisl5/JBeHD2lVp2yeJwDcNTaSH/97W798w0kI=;
        b=QsSfDkRBZcwY75n8HR1G5Tpbn1noX+uJGmYe+oadP6KhvQ6h1s5x9XRDxdXBKUaQ61zhFF
        1bc1OCXOWl7BsjSs0YtCEDIqSispvv+mkr0d/kdfrjjYApoZqCUf73HzyVPCmaZo8NWie8
        LOFQBfFGl/nF8lJu/FKVhSVsSCyaDiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Z4_eLYzOPZ6KxzdnNkWd1Q-1; Thu, 17 Dec 2020 10:10:27 -0500
X-MC-Unique: Z4_eLYzOPZ6KxzdnNkWd1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42DF710054FF;
        Thu, 17 Dec 2020 15:10:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-84.phx2.redhat.com [10.3.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 233E618A50;
        Thu, 17 Dec 2020 15:10:22 +0000 (UTC)
Subject: Re: [PATCH 0/7 nfs-utils] Assorted improvements to handling
 nfsmount.conf
To:     NeilBrown <neilb@suse.de>
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
References: <160809318571.7232.10427700322834760606.stgit@noble>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5c3e7332-b8f1-3cd7-2a38-e003688aa1e8@RedHat.com>
Date:   Thu, 17 Dec 2020 10:11:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/15/20 11:43 PM, NeilBrown wrote:
> The handling of version specifiers in mount.nfs, and even in the kernel,
> is somewhat ideosyncratic when multiple versions are listed.
> 
> For example,  "-o vers=4.1,nfsvers=3" will result in both versions being
> passed to the kernel, and the kernel complaining because version 3
> doesn't support minor version numbers.
> Conversly, "-o nfsvers=4.1,vers=3" will result in the "nfsvers=4.1"
> being stripped off and vers=3 being used.
> 
> Further, version settings found in /etc/nfsmount.conf are sometimes
> ignored if a version is given on the command line, and sometimes not.
> If "nfsvers=3" is in the config file, then the presense of "-o vers=4.1"
> will cause it to be ignored, the presense of "-o nfsvers=4.1" will too, but
> mainly because of sloppy code.  However "-o v4.1" won't cause the config
> file setting to be ignored.
> 
> This series cleans up all of this and some related issues, and updates
> the man page.
> 
> With other options, the last option listed on the command line wins.
> I have not tried to provide that for version options.  Instead, if there
> are multiple version options listed, and error is reported.
> 
> Thanks,
> NeilBrown
The series is Committed! (tag:  nfs-utils-2-5-3-rc3)

steved.
 
> 
> ---
> 
> NeilBrown (7):
>       mount: configfile: remove whitesspace from end of lines
>       mount: report error if multiple version specifiers are given.
>       Revert "mount.nfs: merge in vers= and nfsvers= options"
>       mount: convert configfile.c to use parse_opt.c
>       mount: options in config file shouldn't over-ride command-line options.
>       mount: don't add config-file protcol version options when already present.
>       mount: update nfsmount.conf man page
> 
> 
>  utils/mount/configfile.c      | 230 +++++++++++-----------------------
>  utils/mount/network.c         |  36 +++---
>  utils/mount/nfsmount.conf.man | 110 ++++++++++------
>  utils/mount/parse_opt.c       |  12 +-
>  utils/mount/parse_opt.h       |   3 +-
>  5 files changed, 174 insertions(+), 217 deletions(-)
> 
> --
> Signature
> 

