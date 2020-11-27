Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7950E2C7287
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Nov 2020 23:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbgK1VuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Nov 2020 16:50:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729715AbgK0TrO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 14:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=V+fxQ+9ZE4mMvoPeeRpISpaVS5sv+7iMxFHbjI4wlvg=;
        b=Qt8Boa+UprtWzusbLN9qGVZmjCcM0FhlVinjmLaM/yfzqVnWfJ8v0yjr3UmpoQ6gagORjN
        JUH0V5mgHXZyS4ACORArIZM9u14JASQoDGOjZey1lhzDBsOOzXIXbQPA+gdg2U9bJH5IGM
        x10e+2mmfyL8afqaVqp3z67XHDwYgo0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-5u0gfOz0NBqWvRgmNm5dgQ-1; Fri, 27 Nov 2020 14:43:37 -0500
X-MC-Unique: 5u0gfOz0NBqWvRgmNm5dgQ-1
Received: by mail-qv1-f72.google.com with SMTP id f2so566594qvb.7
        for <linux-nfs@vger.kernel.org>; Fri, 27 Nov 2020 11:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V+fxQ+9ZE4mMvoPeeRpISpaVS5sv+7iMxFHbjI4wlvg=;
        b=oz4a6ua6CyBgrLZeYYgjTSCUYhTM+MGa0X70Px6zerZmSGbCj+oWumQh/agzBdy6vv
         ko6PpazBFynJmgKV+bpPV3MEI98Sx116tpFVkgzpMNhQWcr0MtdFRBAgEd7VORYmzFvU
         m7oF0FlA9uqv1a6MtW+rQoyjc4f4lh8MLelVAl+mKfjefyFopGvJxC4Bc/nQNJkmgX4c
         eA8MVtBdUPGkzdSfFO6WSaGAKBDdA//+wiR3gVC1427LK3eCpnh6cz0bsMRnQMv1++io
         mCVbbGn9GzJVQl2Ksv6hyxa1hyhuvLkqMzpTI/oURcaDPTaxXhtXmO9c8d/i6n99+Qcq
         dAjA==
X-Gm-Message-State: AOAM5327hAn3I1Zc6S7IT44pspwPEh08u4dpAYxUCAQ4vHScdgG254A8
        t8n/NDMV+7Wn2rO8GHAUdGNQ8XvoTufV2lZQz+6Uq8D3P3KyIRJoh3RQil6hsI9p+tQtQ8M2D4t
        Id6U19NBUOFBQ+sZTWIyT
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr9957745qkg.479.1606506216897;
        Fri, 27 Nov 2020 11:43:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6lodK6voISGIkjg9/FPTLrFucmHCETDXMNpIo6ewNM+fOmDKlJ1dM4RCPu/VocOlLLHaAVg==
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr9957714qkg.479.1606506216683;
        Fri, 27 Nov 2020 11:43:36 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l7sm6906770qtp.19.2020.11.27.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:43:36 -0800 (PST)
From:   trix@redhat.com
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] NFS: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:43:25 -0800
Message-Id: <20201127194325.2881566-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/sunrpc/auth_gss/gss_generic_token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_generic_token.c b/net/sunrpc/auth_gss/gss_generic_token.c
index fe97f3106536..9ae22d797390 100644
--- a/net/sunrpc/auth_gss/gss_generic_token.c
+++ b/net/sunrpc/auth_gss/gss_generic_token.c
@@ -46,7 +46,7 @@
 /* TWRITE_STR from gssapiP_generic.h */
 #define TWRITE_STR(ptr, str, len) \
 	memcpy((ptr), (char *) (str), (len)); \
-	(ptr) += (len);
+	(ptr) += (len)
 
 /* XXXX this code currently makes the assumption that a mech oid will
    never be longer than 127 bytes.  This assumption is not inherent in
-- 
2.18.4

