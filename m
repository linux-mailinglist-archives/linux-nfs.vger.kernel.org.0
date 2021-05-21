Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA64538BFF1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhEUGsa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 02:48:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhEUGs2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 02:48:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2543EAC46;
        Fri, 21 May 2021 06:47:03 +0000 (UTC)
Date:   Fri, 21 May 2021 08:47:01 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Yong Sun <yosun@suse.com>
Subject: pynfs: COUR2, EID50 test failures
Message-ID: <YKdXZa6Izs7kqgfE@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

what's wrong with pynfs COUR2, EID50 tests?
They're failing on various kernels.
I got these failures on 5.11.12 (openSUSE package), 5.13.0-rc2 (mainline on
openSUSE), 4.9.0 (Debian package):

COUR2    st_courtesy.testLockSleepLock                            : FAILURE
           OP_OPEN should return NFS4_OK, instead got
           NFS4ERR_GRACE

EID50    st_exchange_id.testSSV                                   : FAILURE
           nfs4lib.NFS4Error: OP_EXCHANGE_ID should return
           NFS4_OK, instead got NFS4ERR_ENCR_ALG_UNSUPP

Nothing in dmesg (tested with "rpcdebug -m nfsd -s lockd").
Or is it just my wrong setup?

Kind regards,
Petr
