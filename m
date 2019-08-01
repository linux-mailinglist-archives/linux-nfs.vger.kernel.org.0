Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634127E35F
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbfHATgz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 15:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388609AbfHATgz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 15:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 325AE3342DEB;
        Thu,  1 Aug 2019 19:36:55 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8E81001281;
        Thu,  1 Aug 2019 19:36:54 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id 29FF01804A0; Thu,  1 Aug 2019 15:36:54 -0400 (EDT)
Date:   Thu, 1 Aug 2019 15:36:54 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190801193654.GA12211@parsley.fieldses.org>
References: <20190723205846.GB19559@fieldses.org>
 <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org>
 <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org>
 <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
 <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
 <20190801181158.GC19461@fieldses.org>
 <CAN-5tyEiO=kBQC=pLu_aeVfV+3f3KWFbz_1ooG8qBLoBqFaehQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEiO=kBQC=pLu_aeVfV+3f3KWFbz_1ooG8qBLoBqFaehQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 01 Aug 2019 19:36:55 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 01, 2019 at 02:24:04PM -0400, Olga Kornievskaia wrote:
> i was just looking at close_lru and delegation_lru but I guess that's
> not a list of delegation or open stateids but rather some complex of
> not deleting the stateid right away but moving it to nfs4_ol_stateid
> and the list on the nfsd_net. Are you looking for something similar
> for the copy_notify state or can I just keep a global list of the
> nfs4_client and add and delete of that (not move to the delete later)?

A global list seems like it should work if the locking's OK.

--b.
