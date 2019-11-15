Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFAFE26D
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfKOQOL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 11:14:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21431 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727461AbfKOQOL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 11:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573834450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bh1m9G8+/YSs26f0udDCREZzDBIHMdCmZtMn/k0iIK0=;
        b=TR5a3lFAASopalyEuTul1yUCi20E2iqWt1t+vYy6dGMQtn3CK7jELAO9K4NAX2Yjf7yIAR
        MXGAw8wrJ9qPg0DPwPYCgmxrNAskhZ015147uOGAo/q8LgAA3ly5Qb5vwjobNuqLIk4Ko/
        uzz7uRvDQscWeVHFwGvh4e3X6SkEVWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-AJMxQ3UsPEK9FzjXIw_ixw-1; Fri, 15 Nov 2019 11:14:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0578F1883531;
        Fri, 15 Nov 2019 16:14:08 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B26545D6D0;
        Fri, 15 Nov 2019 16:14:07 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.4.2 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <34828ccd-3982-9278-fa5e-dd961731d7f6@RedHat.com>
Date:   Fri, 15 Nov 2019 11:14:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: AJMxQ3UsPEK9FzjXIw_ixw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

This is a maintenance release to fix some issues internal to the git tree..=
. =20

This release does include the update nfsdcld support=20
as well as the updated mountstats and iostats commands.


The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.4.2/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.4.2

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.4.2/2.4.2-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.4.2/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

