Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B8235428D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhDEOGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 10:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235903AbhDEOGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Apr 2021 10:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617631596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=metaO8wH3DJ2s8hgG3w3KZr29M2C6KLasAK1DMNHw9I=;
        b=akuY0HfcaQgxYPvi7YK+yPENGpgddIE8ffUpGbJmnwQtLm3ZAu12Q6nMY5Qm5mTQdrvAii
        DnnEBhv9O9W6d7017oiY2owyfa+y4QDW0Qf0JfIO7YnpoXmaf1zQjnDg2gTQN8AORSaBZ7
        hqpmDpaLXFRoZ4hQ7TwtqrvP4swo5Go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-NCm2lOs3N3WoSzqGmho7qQ-1; Mon, 05 Apr 2021 10:06:35 -0400
X-MC-Unique: NCm2lOs3N3WoSzqGmho7qQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA73A87504E;
        Mon,  5 Apr 2021 14:06:33 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-117-172.rdu2.redhat.com [10.10.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA2BA19630;
        Mon,  5 Apr 2021 14:06:33 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id C68B41205B6; Mon,  5 Apr 2021 10:06:32 -0400 (EDT)
Date:   Mon, 5 Apr 2021 10:06:32 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     David Noveck <davenoveck@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
Subject: Re: [nfsv4] [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data
 within the last hole
Message-ID: <YGsZaBxEbkcuvPRH@pick.fieldses.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>
 <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YQXPR0101MB0968C9AB372DC12408F496D8DD7B9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <20210402210157.GC16427@fieldses.org>
 <CADaq8jeNrA3TexAM0dBxj7LSoooyRna6wU-VomDKovodYTdqKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADaq8jeNrA3TexAM0dBxj7LSoooyRna6wU-VomDKovodYTdqKA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 02, 2021 at 10:58:15PM -0400, David Noveck wrote:
> However, if one had been made, it would have been rejected.   It is not the
> function of the errata mechanism to make substantive protocol changes like
> this, even if the wg thinks the original consensus decision was wrong.  To
> do that you need a standards-track document updating the original one and
> addressimg compatibility issues. Nobody was up for that at the time or
> seems to be now.

Do we have any sort of informal todo list for a 7862bis?

--b.

