Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED96E9CF5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDTUUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDTUUw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 16:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64A1FF0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682022006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0UKMauEOX4K8knGNCGpDmavHegSuS0xNqW48pXYHNIk=;
        b=Eq9vTLQyTqEoPTwknPUKdAkrRbiMh/dPncXxCMzMazSCK4uZ/+kCk7r3/gC6lGXfCXV7qC
        j/CSE+Y+ix7YJoipGMxQLzpvKQk6JvFgsDLIMjDFBRi8k//zsUBQPWO/wJaAwCh7RpX7FM
        1LDFXzS862hU+DQ4i75ckcKnqs/QJsc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-yeFmiqVCPVyWnWOJfS4mxA-1; Thu, 20 Apr 2023 16:20:05 -0400
X-MC-Unique: yeFmiqVCPVyWnWOJfS4mxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1054A85A588;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0338A2026D3C;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 9724B1A27F5; Thu, 20 Apr 2023 16:20:04 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: [RFC PATCH 0/5] SUNRPC: Add option to store GSS credentials in
Date:   Thu, 20 Apr 2023 16:19:59 -0400
Message-Id: <20230420202004.239116-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches are a work in progress.  They add the option to store GSS
credentials in user keyrings as an alternative to the credential cache
hashtables that are currently used.  The goal is to give users the
ability to destroy their credentials on-demand.

There have been other attempts to give users the ability to destroy
their GSS credentials in the past, for example:

https://lore.kernel.org/all/1354560315-2393-2-git-send-email-andros@netapp.com/T/
and
https://lore.kernel.org/linux-nfs/20170807212355.29127-1-kolga@netapp.com/

But those attempts were not accepted, so I wanted to get some feedback
on what I currently have before trying to tackle some of the more thorny
issues, such as what to do when a user has files open for write,
potentially with dirty data to be written out.

These patches are also available at:
https://github.com/scottmayhew/linux/tree/gss-cred-keyring

Here's a quick demo:

[smayhew@centos9 ~]$ sudo mount nfs:/export /mnt/t
[smayhew@centos9 ~]$ ls -l /mnt/t/test[12]
-rw-r--r--. 1 testuser1 testuser1 32 Apr 20 15:34 /mnt/t/test1
-rw-r--r--. 1 testuser2 testuser2 32 Apr 20 15:33 /mnt/t/test2

[smayhew@centos9 ~]$ kinit testuser1
Password for testuser1@SMAYHEW2.TEST: 

[smayhew@centos9 ~]$ date >/mnt/t/test1

[smayhew@centos9 ~]$ keyctl show
Session Keyring
 400651412 --alswrv   1000  1000  keyring: _ses
 376802674 --alswrv   1000 65534   \_ keyring: _uid.1000
 297894262 --als--v   1000  1000       \_ gss_cred: clid:1 id:1000 princ:(none)

[smayhew@centos9 ~]$ date >/mnt/t/test2
-bash: /mnt/t/test2: Permission denied

[smayhew@centos9 ~]$ kinit testuser2
Password for testuser2@SMAYHEW2.TEST: 

[smayhew@centos9 ~]$ keyctl unlink 297894262
1 links removed

Note: At this point the old gss_cred hasn't actually been destroyed,
because the key that is referencing it is also linked to a special
keyring hanging off the gss_auth structure.  When the user creates a new
gss_cred and the key referencing the new gss_cred is linked to the
gss_auth keyring, that causes the old gss_cred to be destroyed and a 
RPCSEC_GSS_DESTROY is sent to the server.  If the user were to unlink
their gss_cred key and do nothing else, then the cred would be destroyed
when the gss_auth is destroyed (i.e. on umount).

[smayhew@centos9 ~]$ keyctl show
Session Keyring
 400651412 --alswrv   1000  1000  keyring: _ses
 376802674 --alswrv   1000 65534   \_ keyring: _uid.1000

[smayhew@centos9 ~]$ date >/mnt/t/test2

[smayhew@centos9 ~]$ keyctl show
Session Keyring
 400651412 --alswrv   1000  1000  keyring: _ses
 376802674 --alswrv   1000 65534   \_ keyring: _uid.1000
  83204766 --als--v   1000  1000       \_ gss_cred: clid:1 id:1000 princ:(none)

[smayhew@centos9 ~]$ date >/mnt/t/test1
-bash: /mnt/t/test1: Permission denied

-Scott

Scott Mayhew (5):
  keys: export keyring_ptr_to_key()
  keys: add keyring_gc_custom()
  keys: add dest_keyring parameter to request_key_with_auxdata()
  keys: add the ability to search user keyrings in
    search_cred_keyrings_rcu()
  SUNRPC: store GSS creds in keyrings

 fs/nfs/nfs4idmap.c             |   2 +-
 include/linux/key.h            |   9 +-
 include/linux/sunrpc/auth.h    |   4 +-
 include/trace/events/rpcgss.h  |  46 ++++-
 net/sunrpc/auth.c              |   9 +-
 net/sunrpc/auth_gss/auth_gss.c | 338 +++++++++++++++++++++++++++++++--
 security/keys/internal.h       |   1 +
 security/keys/keyring.c        |  16 +-
 security/keys/process_keys.c   |  78 ++++++--
 security/keys/request_key.c    |   5 +-
 10 files changed, 470 insertions(+), 38 deletions(-)

-- 
2.39.2

