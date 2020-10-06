Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A728528D
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 21:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFTgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 15:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgJFTgN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 15:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602012972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/7H6cvyS654XVvdfi3xpFiwAkZtjXGpPa8qC11SASc=;
        b=IPhVRc11hMIm3sovsvUOypen1h67ACn/G4UjrdpDaVhxBrcZpwq24zf46D9fDpeb4ILeu1
        yIdVjJJv54o4Cj3C6j4B39z5jmRuAs/j+KYzzfwtzHDz55nQvep9JWcEXqXxbZWY1MkDcL
        XRCvAxECv2ss5oUJ68GLIZM8/vhX9xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-dy2bgqdoO7OpH9zLOHWKiA-1; Tue, 06 Oct 2020 15:36:10 -0400
X-MC-Unique: dy2bgqdoO7OpH9zLOHWKiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8631F1019624;
        Tue,  6 Oct 2020 19:36:09 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C822C31E;
        Tue,  6 Oct 2020 19:36:08 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: unsharing tcp connections from different NFS mounts
Date:   Tue, 06 Oct 2020 15:36:07 -0400
Message-ID: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
In-Reply-To: <20201006151335.GB28306@fieldses.org>
References: <20201006151335.GB28306@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:

> NFSv4.1+ differs from earlier versions in that it always performs
> trunking discovery that results in mounts to the same server sharing a
> TCP connection.
>
> It turns out this results in performance regressions for some users;
> apparently the workload on one mount interferes with performance of
> another mount, and they were previously able to work around the 
> problem
> by using different server IP addresses for the different mounts.
>
> Am I overlooking some hack that would reenable the previous behavior?
> Or would people be averse to an "-o noshareconn" option?

I suppose you could just toggle the nfs4_unique_id parameter.  This 
seems to
work:

flock /sys/module/nfs/parameters/nfs4_unique_id bash -c "OLD_ID=\$(cat 
/sys/module/nfs/parameters/nfs4_unique_id); echo imalittleteapot > 
/sys/module/nfs/parameters/nfs4_unique_id; mount -ov4,sec=sys 
10.0.1.200:/exports /mnt/fedora2; echo \$OLD_ID > 
/sys/module/nfs/parameters/nfs4_unique_id"

I'm trying to think of a reason why this is a bad idea, and not coming 
up
with any.  Can we support users that have already found this solution?

Ben

