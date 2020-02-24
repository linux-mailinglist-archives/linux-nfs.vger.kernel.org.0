Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D449F169CC1
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2020 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXDz3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Feb 2020 22:55:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgBXDz3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Feb 2020 22:55:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so4656198pfc.1
        for <linux-nfs@vger.kernel.org>; Sun, 23 Feb 2020 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=LrVEI3BNouSceLN9SyFZn1j+dNf/Jyxt9Mk5KiIrYfg=;
        b=vJhzko9htE22mXRcAej4lkplAnYnDv2Hpd8TyTtuU1qkD3gpr9zBTEsgZsQgnPVUAE
         CDO4P5ve8IhVl6Sroyta7uxcNOZ2Pj4GcqlFSISrBjIEArgXMs7NWdUYEtemCZkebm9N
         ojHXp7hyKtnQzrTfBIKeHd9qjhq6WCaeYacCmMwEGGuLxNS8OcnttwNyIMJXptJj8MbF
         IF+GhDyqzbOOEzySYXJvY/dWkz1wlZu1MwRsAZXxpb845wKVJbNHZM9OMUs8Va1QPynk
         AeJyEpQYtTu1b9XKFdVKFAxHkIyYbEd1flTJe6oPBeA7GWiLrdy2+R6+ExIUhwjJyvyi
         EwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=LrVEI3BNouSceLN9SyFZn1j+dNf/Jyxt9Mk5KiIrYfg=;
        b=CERYV6gXZQyAFji8yForpUHF4HiI5eUid4LuLdnDDmfK+ZX3wMSVwk8k1jkLckkOtt
         VGQN33JuqarFxnxfhlqyM3xjTFkpklERWejKpfwP/PQti7Auo6QbNkCoCLn4gb12KHWl
         GdwirPI1XOhxKzdS9k2an6YAKI6ob8eFKHYb6JIIJNi3WW0fQRpOe0na0RqIchzGRs2Z
         4ouvg2ftC+BEDdQzQIYCpYOxMkqqO+FPCyNeMRdelBDBGXvNABMnMXm10bk/d0r8mecI
         E9zTG1TFcQmXLB2d0XjCi0nZty1Wn8Hn0WTWNa1XjZThsWXZuQwXl48e4MByqz3TANnh
         3HDQ==
X-Gm-Message-State: APjAAAXoberqhWSlhSDIQTCOD1pv9cu282v79EfLrU2neMaHdRVZksQX
        eO6h4KA8vUT56iq51o2lO/el1g==
X-Google-Smtp-Source: APXvYqw30q/8Ln3CRgQsmF0EBobRaKysNBn1uVpXxW8Ya8vLJtw2AdS9WBIWBTkGuAheyk3a4a9aSg==
X-Received: by 2002:a63:5808:: with SMTP id m8mr13906094pgb.252.1582516528546;
        Sun, 23 Feb 2020 19:55:28 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 70sm10370984pfw.140.2020.02.23.19.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 19:55:28 -0800 (PST)
Date:   Sun, 23 Feb 2020 19:55:20 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     trond.myklebust@hammerspace.com, bfields@fieldses.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: Fw: [Bug 206651] New: kmemleak in rpcsec_gss_krb5
Message-ID: <20200223195520.0afdad4a@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Begin forwarded message:

Date: Mon, 24 Feb 2020 03:16:28 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 206651] New: kmemleak in rpcsec_gss_krb5


https://bugzilla.kernel.org/show_bug.cgi?id=206651

            Bug ID: 206651
           Summary: kmemleak in rpcsec_gss_krb5
           Product: Networking
           Version: 2.5
    Kernel Version: 4.19.36
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: kircherlike@outlook.com
        Regression: No

During the loading and unloading of the kernel module, kmemleak discovered a
leak problem. To reproduce this problem, you only need to enable the kmemleak
option. 
CONFIG_DEBUG_KMEMLEAK=y 
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=10000: 
Then, load and unload the module. 
modprobe rpcsec_gss_krb5 
modprobe -r rpcsec_gss_krb5: 
Repeat this process every 1000 cycles to obtain the leaked information. 
Repeat the preceding operations for 115 times. The SUnreclaim memory will
increase by 85 MB. 

After checking the loading source code of rpcsec_gss_krb5, we find that the
svcauth_gss_register_pseudoflavor function in the svcauth_gss.c file contains
the following code segment: 

...
        test = auth_domain_lookup(name, &new->h);
        if (test != &new->h) { /* Duplicate registration */
                auth_domain_put(test);
                kfree(new->h.name);
                goto out_free_dom;
        }
        return 0;

out_free_dom:
        kfree(new);
out:
        return stat;
...

The structure of new->h.name is dynamically applied by kstrdup. When
auth_domain_lookup cannot find new->h.name in the hash table, it is added to
the hash table. 

When the module is unloaded, the structure in the hash table is not released
accordingly. As a result, the module is leaked. I modified the gss_mech_free
function to forcibly release the structure in the hash table. 

...
        for (i = 0; i < gm->gm_pf_num; i++) {
                pf = &gm->gm_pfs[i];
+               struct auth_domain *test;
+               test = auth_domain_find(pf->auth_domain_name);
+               if (test != NULL) {
+                       test->flavour->domain_release(test);
+               }
                kfree(pf->auth_domain_name);
...

Perform the leakage test again. The memory usage of SUnreclaim does not
increase. 

I want a complete destructor to free the hash table, not by force.

-- 
You are receiving this mail because:
You are the assignee for the bug.
