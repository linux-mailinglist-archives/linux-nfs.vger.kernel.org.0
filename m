Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02993B70B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbfFJOOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 10:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3671 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390716AbfFJOOx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Jun 2019 10:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91864308794F;
        Mon, 10 Jun 2019 14:14:48 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD17760BF1;
        Mon, 10 Jun 2019 14:14:46 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: client skips revalidation if holding a delegation
Date:   Mon, 10 Jun 2019 10:14:46 -0400
Message-ID: <243407AC-A416-4FF2-A09B-B1362C6206D9@redhat.com>
In-Reply-To: <7289561F-686E-4425-B0CE-F3E5800C033D@redhat.com>
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
 <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
 <CFD3CE5E-5081-4A4D-B67E-41D9E7A3D5C5@redhat.com>
 <a595b6962b2e083fef8ad2d3534e1d0964995560.camel@hammerspace.com>
 <7289561F-686E-4425-B0CE-F3E5800C033D@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Jun 2019 14:14:53 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Jun 2019, at 15:00, Benjamin Coddington wrote:

> At least now I can spend some time on it and not feel aimless, thanks for
> the closer look.

I am not finding a reliable way to fix this and retain the optimization.  I
will send a patch to remove it.

Ben
