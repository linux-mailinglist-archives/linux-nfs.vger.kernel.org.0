Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960541D2310
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 01:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgEMX3t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 May 2020 19:29:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732573AbgEMX3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 May 2020 19:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589412588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WMn6vK5nU51JnkGUpFOMQ0Pp2c+mfmz91m/RqUfp4s=;
        b=H/e2LoLTdc458Ok0nMdTPzKufw+tSMYgGhLCcY4MdDPmmHWTDVs2cnnqXAvDpbkBNoNZdA
        XpPjGYRAT+PyGjzBZtSfSkDypwtCd+6YoqBezDofmkk1dSmb81Ro9bSaq5faULGJqSQRbc
        iaqNx4z3eYorYn6jFmdnkeaOIl4Zvj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-0fAv4CJaMLiUENuiqa61JQ-1; Wed, 13 May 2020 19:29:41 -0400
X-MC-Unique: 0fAv4CJaMLiUENuiqa61JQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FE8980183C;
        Wed, 13 May 2020 23:29:40 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-113-206.rdu2.redhat.com [10.10.113.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5295A60C47;
        Wed, 13 May 2020 23:29:39 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 771C71203D3; Wed, 13 May 2020 19:29:37 -0400 (EDT)
Date:   Wed, 13 May 2020 19:29:37 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: 'Directory with parent 'rpc_clnt' already
 present!'
Message-ID: <20200513232937.GB34451@pick.fieldses.org>
References: <1589409520-1344-1-git-send-email-bfields@redhat.com>
 <20200513224033.GA1415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513224033.GA1415@fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 13, 2020 at 06:40:33PM -0400, J. Bruce Fields wrote:
> On Wed, May 13, 2020 at 06:38:40PM -0400, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > Each rpc_client has a cl_clid which is allocated from a global ida, and
> > a debugfs directory which is named after cl_clid.
> > 
> > We're releasing the cl_clid before we free the debugfs directory named
> > after it.  As soon as the cl_clid is released, that value is available
> > for another newly created client.
> > 
> > That leaves a window where another client may attempt to create a new
> > debugfs directory with the same name as the not-yet-deleted debugfs
> > directory from the dying client.  Symptoms are log messages like
> > 
> > 	Directory 4 with parent 'rpc_clnt' already present!
> 
> This also cleared up a "file-max limit 199277 reached" warning, which
> suggests to me a leak in an error path somewhere (I think everything's
> supposed to work normally even if debugfs file createion fails), but I
> don't see it.

Whoops, I spoke to soon, I'm still seeing that warning, so that's an
unrelated issue.

--b.

