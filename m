Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1351FCDA2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFQMqR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 08:46:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22306 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726280AbgFQMqQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jun 2020 08:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592397975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGXz5o+dS7Q8T0Jy6yaGzTf1OoA4BdHIRL9JLo9H8+U=;
        b=SJsLb9tItXwSkwiWnhqHt+HzBcWJukL95lAGciWFCE21k6z8gDwvcR9zuHlC6I+0lORzP2
        I4+Z/6qk7jWdM245TyigbEbo5x/qIH3cbNqppINltDLsQPm6WAaCZkwjm9dR07kfGh0Ogm
        IdHfUeMkicbL/0JObBVL1ZzqK0lz9uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-fAGVjgJHN0eU3ntodfTypA-1; Wed, 17 Jun 2020 08:46:13 -0400
X-MC-Unique: fAGVjgJHN0eU3ntodfTypA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BCD1134DA;
        Wed, 17 Jun 2020 12:46:12 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-232.rdu2.redhat.com [10.10.115.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C055C1D4;
        Wed, 17 Jun 2020 12:46:12 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2628F120476; Wed, 17 Jun 2020 08:46:11 -0400 (EDT)
Date:   Wed, 17 Jun 2020 08:46:11 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl
Message-ID: <20200617124611.GA266716@pick.fieldses.org>
References: <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
 <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li>
 <20200617005849.GA262660@pick.fieldses.org>
 <20200617045829.GA26611@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617045829.GA26611@lorien.valinor.li>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 17, 2020 at 06:58:29AM +0200, Salvatore Bonaccorso wrote:
> On Tue, Jun 16, 2020 at 08:58:49PM -0400, J. Bruce Fields wrote:
> Thank you, could test this on my test setup and seem to work properly.

Great, thanks.

> Should it also be CC'ed to stable@vger.kernel.org so it is picked up
> by the current supported stable series?

Will do.--b.

