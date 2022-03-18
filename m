Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23E74DD9CA
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 13:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiCRMgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Mar 2022 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMgN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Mar 2022 08:36:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348A16F056
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 05:34:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m12so10064138edc.12
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=6iWZLctKPo2inLAx3goAwk3G760139K0LMVxfAxjcoU=;
        b=Ca2knRlOhTiuTkI1CtmrBbX2MhXY9gmK74B4ujeX/nTq5KU04r77D2qCQBicyjCxkO
         z8KmZcphByWpI06kN8m+DXDY2Tl60tCwIXF0+wY63FRcmWQijfYek6Ps6P7mv7ytYA/t
         Sjlo+cPa3N48aHGZPov+gZDNluyWRT1XISgdGIo6RVvC2vk/nZRf/Rqr6A2hnFG7+DUY
         ziCNPRnuzxgwP7j1SyQpalf2j/541jmMz7mVILHs6ENbYnram3vmkKhk4k+mQ3OTM8wm
         h2zqp99qB26m0oXST+3sfPkVespApxpCXAsLFSW4U3d/nDHsIZLhFYl5yZp8zxQnaGll
         2hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6iWZLctKPo2inLAx3goAwk3G760139K0LMVxfAxjcoU=;
        b=bJmAGJ/EN6fswkooSoJ/hl7z8UCKJkO0P7o6ByyGxFiphf6sQ4JwS/VnU0GqDQl9/8
         0LcBL6/EgrIPoL0psqYJkRlcCFRgRzu7qeBmQGU6SckW3AmwO28WCtSub9TwzgDGb9eU
         q41HOj1olXSx9FLZhtm/1g3tsiVqgSN6e/rbaS62Ea9shiXCJIa0QxP2uZn+OtPewAaI
         l9HOtV+ePuSgRpG64+b734K0yeRpKQE03ZD5exVK8qsxDR2oEvh84D0FrU/38sOeTIUC
         10web1UlraLvJ8778DkUOdP5w6pCT6F4WjOh7AfMACbdg/EvC+ZcyiWsrbE6PgHzK0Bp
         HGaw==
X-Gm-Message-State: AOAM532sDOTbxz6rwr4Nnpfr349Z8rtNIZKpFFUatbmiiCfVt5+eT/Z+
        QfOPmoC674q24Vpt/HGRPzn2w47WtLxZahkHAJrlRo+Iddk=
X-Google-Smtp-Source: ABdhPJzYcjkBFAYl0teBRFacSGASAyC7XdsRJtqEsUlQOrMGC05RM3D+UbYHqAxlJWnqdMR0B5fEvZqKI+hC4zeCBJM=
X-Received: by 2002:a05:6402:510f:b0:418:6d01:3688 with SMTP id
 m15-20020a056402510f00b004186d013688mr9394911edd.24.1647606892753; Fri, 18
 Mar 2022 05:34:52 -0700 (PDT)
MIME-Version: 1.0
From:   tizo <tizone@gmail.com>
Date:   Fri, 18 Mar 2022 09:34:41 -0300
Message-ID: <CAHBowdjBBf_B7_VGw3rEh0ZNeKoABptRy-gA00xTt7CZxMH1yw@mail.gmail.com>
Subject: NFSv4 permissions issues with an exported glusterfs Inbox
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just in case I have asked exactly the same question in serverfault, as
I didn't know that this list existed.

I have a situation with kernel NFS server. I have two exports with
exactly the same ACLs, with full permissions for the
informatica@adtest.xx.xx.xx group. One is
/exports/directo_informatica/, which is the mount point for an LV with
XFS, and the other is /exports/gv0_inf/, which is the mount point for
a glusterfs. The first export works right when mounting it remotely
with NFS, and accessing it with a user of the group
informatica@adtest.xx.xx.xx. The second one doesn't: it can be mounted
correctly, but when trying to access it with the same user it gives
"Permission denied".

If I access directly to the NFS server (ssh) with the same user of the
previous tests, I can access both directories inside /exports/ without
problems. More details at following:

OS: Rocky Linux release 8.5 (Green Obsidian)

fstab for the exported directories:

/dev/mapper/vg_kvm_sistema-lv_directo_informatica
/exports/directo_informatica xfs defaults 0 0
glustersrv02.xx.xx.xx:/gv0_inf /exports/gv0_inf/ glusterfs defaults,acl 0 0

Mount for the exported directories:

/dev/mapper/vg_kvm_sistema-lv_directo_informatica on
/exports/directo_informatica type xfs
(rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
glustersrv02.xx.xx.xx:/gv0_inf on /exports/gv0_inf type fuse.glusterfs
(rw,relatime,user_id=0,group_id=0,allow_other,max_read=131072)

exports file:

/exports
*(sec=krb5p,secure,rw,sync,no_wdelay,no_subtree_check,root_squash,fsid=0)
/exports/directo_informatica
*(sec=krb5p,secure,rw,sync,no_wdelay,no_subtree_check,root_squash,mountpoint)
/exports/gv0_inf
*(sec=krb5p,secure,rw,sync,no_wdelay,no_subtree_check,root_squash,mountpoint,fsid=2)

Exported directories ACLs:

# getfacl /exports/directo_informatica/
getfacl: Removing leading '/' from absolute path names
# file: exports/directo_informatica/
# owner: root
# group: root
user::rwx
user:root:rwx
group::r-x
group:root:r-x
group:informatica@adtest.xx.xx.xx:rwx
mask::rwx
other::---
default:user::rwx
default:user:root:rwx
default:group::r-x
default:group:root:r-x
default:group:informatica@adtest.xx.xx.xx:rwx
default:mask::rwx
default:other::---

# getfacl /exports/gv0_inf/
getfacl: Removing leading '/' from absolute path names
# file: exports/gv0_inf/
# owner: root
# group: root
user::rwx
user:root:rwx
group::r-x
group:root:r-x
group:informatica@adtest.xx.xx.xx:rwx
mask::rwx
other::---
default:user::rwx
default:user:root:rwx
default:group::r-x
default:group:root:r-x
default:group:informatica@adtest.xx.xx.xx:rwx
default:mask::rwx
default:other::---

Directories mounted remoteley:

gluster02.adtest.xx.xx.xx:/directo_informatica on /prueba2 type nfs4
(rw,relatime,vers=4.2,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5p,clientaddr=10.2.100.8,local_lock=none,addr=10.2.100.8)
gluster02.adtest.xx.xx.xx:/gv0_inf on /prueba type nfs4
(rw,relatime,vers=4.2,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5p,clientaddr=10.2.100.8,local_lock=none,addr=10.2.100.8)

NFSv4 ACLs remotely:

$ nfs4_getfacl /prueba2
# file: /prueba2
A::OWNER@:rwaDxtTcCy
A::root@idmpru.fnr.gub.uy:rwaDxtcy
A::GROUP@:rxtcy
A:g:root@idmpru.fnr.gub.uy:rxtcy
A:g:informatica@adtest.xx.xx.xx@idmpru.xx.xx.xx:rwaDxtcy
A::EVERYONE@:tcy
A:fdi:OWNER@:rwaDxtTcCy
A:fdi:root@idmpru.xx.xx.xx:rwaDxtcy
A:fdi:GROUP@:rxtcy
A:fdig:root@idmpru.xx.xx.xx:rxtcy
A:fdig:informatica@adtest.xx.xx.xx@idmpru.xx.xx.xx:rwaDxtcy
A:fdi:EVERYONE@:tcy

$ nfs4_getfacl /prueba
# file: /prueba
A::OWNER@:rwaDxtTcCy
A::GROUP@:rwaDxtcy
A::EVERYONE@:tcy

Any help is appreciated. Thanks very much.
