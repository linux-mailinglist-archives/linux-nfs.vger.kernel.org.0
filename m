Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEF39855C
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFBJhq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhFBJhp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 05:37:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AFC061574
        for <linux-nfs@vger.kernel.org>; Wed,  2 Jun 2021 02:36:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x38so2332038lfa.10
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=XX8vd85HZ2VaEUDD0esENfGpcXi16wW+VEMTVGIKv7w=;
        b=M0RckkE1Da89NxaFwon22C9bzZDVphZTXDZZNjm0rzfB8+r8hL+XQLmp2fi3fd8MPL
         fmj1iUFuSeizuojnOqCH562VlOnjHOJifOOq5TUyqJMxD6Hh/FdHLaL1DBhmz/CBUgNZ
         5cmqCVigrcPb06KiwXo3RV7NTP4sAVN5S5gwVBCf1ul1PWYKFSzFhTog6FcsYsMnD3Xp
         J89xSWNyLNwiO+KPoQS11GN9j3jwWSI5dnKpcz5EktxvniNhGslrr/qFsPCgBGHAala8
         E9UhXsODAtWqyUIrSqUCttM/QiEqopLElnPi62nBHyXkoyJGRsJQlBv60nDoGKRNyPE8
         RDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XX8vd85HZ2VaEUDD0esENfGpcXi16wW+VEMTVGIKv7w=;
        b=qIoIgg1qf+zymjP8f30L1uTMrLfkGum/QZBflWHCWMe048iF1tKUZ1OxNKcCH/34va
         t9l7EJyQm0EIY+d75TwVN/gt5v4ZVYg5pUiMZdLXfTnF570HHgMOkpzZ8qMI0FU/e8cU
         JJrGse3z7S5itbIWkiesYG3awqHA2zmzmkI5444SXZTRzb71eylS1Bojg3QI5i2AHWey
         AGlmH3nlPrvoHqImge9ax6bOPciFypvscdOAX5YmLAiXCkeFtl5P4T6uNSL1w9HStetH
         OrgiRz1qbbyKMHRcKsxlx2btxePXizg3KRBrTbNKgZVac/psxK9V9akuQmHK1IgB0uxX
         i1zA==
X-Gm-Message-State: AOAM532E2VVK2rxyll8CFpAl2KxPJ1gGOyMGgnFoLbl08o/9hZ6gvcbc
        i1L7Vb1i2IbQlDL/JpUqIuHVD51aGs/udWqVPbyJdcEu1jbebg==
X-Google-Smtp-Source: ABdhPJxPMUw2WfJQD90Cvv1JvzduoihjjacmDgqHGXuQACCgQIAGKeo3Fo9GebxeP8DoIlPr4eMjAGL2SPfR8Vh9r4s=
X-Received: by 2002:a05:6512:603:: with SMTP id b3mr6651288lfe.376.1622626561017;
 Wed, 02 Jun 2021 02:36:01 -0700 (PDT)
MIME-Version: 1.0
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Wed, 2 Jun 2021 12:35:50 +0300
Message-ID: <CANkgwesHwdXYs-y4H+B=7Ywwr7jdJN4LHd=cE=aBPip8qXFwEg@mail.gmail.com>
Subject: pynfs: rpc AuthGss.init_cred fails on missing attrs/wrong usage of
 gssapi (nfs4 client)
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Using the latest pynfs (from git) with python-gssapi 0.6.4.
Trying to test NFS4 client with flavor=rpc.RPCSEC_GSS from python:

opts=...
opts.flavor=rpc.RPCSEC_GSS
self.env = environment.Environment(opts)

Getting 'AttributeError' from different places.

Stack trace1:
nfs4/nfs4_client.py:61: in __init__
    self.env = environment.Environment(opts)
lib/python3.6/site-packages/nfs4/server41tests/environment.py:128: in __init__
    krb5_cred = AuthGss().init_cred(call, target="nfs@%s" % opts.server)
lib/python3.6/site-packages/rpc/security.py:249: AttributeError
>       target = gssapi.Name(target, gssapi.NT_HOSTBASED_SERVICE)
E       AttributeError: module 'gssapi' has no attribute 'NT_HOSTBASED_SERVICE'

For this error, in python-gssapi-0.6.4/gssapi/__init__.py I see that
correct name for this attribute is 'C_NT_HOSTBASED_SERVICE' (not
'NT_HOSTBASED_SERVICE'):
C_NT_HOSTBASED_SERVICE = bindings.C.GSS_C_NT_HOSTBASED_SERVICE

Stack trace2:
nfs4/nfs4_client.py:61: in __init__
    self.env = environment.Environment(opts)
lib/python3.6/site-packages/nfs4/server41tests/environment.py:128: in __init__
    krb5_cred = AuthGss().init_cred(call, target="nfs@%s" % opts.server)
lib/python3.6/site-packages/rpc/security.py:267: AttributeError
>           token = context.init(target, token, gss_cred)
E           AttributeError: 'Context' object has no attribute 'init'

For this error, in python-gssapi-0.6.4/gssapi/ctx.py file I see that the
'Context' class __init__ method has no parameters, init() method is
really missing.

I suspect that python-gssapi was changed or I'm using the wrong
version/code of the gssapi library.
I tried to use the old gssapi lib version (before fork) -
gssapi-1.6.13 - but I get similar errors.
'README' file for pynfs says that we need the 'python3-gssapi'
package, but it is missing in the repository, so I have to install it
manually.

Please advise what gssapi python library version is proven to work with pynfs.
Thanks!
