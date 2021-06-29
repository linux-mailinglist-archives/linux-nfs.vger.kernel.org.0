Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF13B76E3
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 19:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhF2RHj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 13:07:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45003 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhF2RHj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 13:07:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lyHAc-00022F-8e; Tue, 29 Jun 2021 17:05:10 +0000
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: NFS: nfs_find_open_context() may only select open files
Message-ID: <81cc22c8-051d-6826-e7e2-bd9b7e03bede@canonical.com>
Date:   Tue, 29 Jun 2021 18:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity has found a potential null
pointer dereference in the following commit:

commit 92735943dc6cf52aeaf2ce9aee397dee55e3ef05
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Tue May 11 23:41:10 2021 -0400

    NFS: nfs_find_open_context() may only select open files

The analysis is as follows:

1113 struct nfs_open_context *nfs_find_open_context(struct inode *inode,
const struct cred *cred, fmode_t mode)
1114 {
1115        struct nfs_inode *nfsi = NFS_I(inode);

    1. assign_zero: Assigning: ctx = NULL.

1116        struct nfs_open_context *pos, *ctx = NULL;
1117
1118        rcu_read_lock();

    2. Condition 1 /* !0 */, taking true branch.
    3. Condition !rcu_read_lock_any_held(), taking true branch.
    4. Condition debug_lockdep_rcu_enabled(), taking true branch.
    5. Condition !__warned, taking true branch.
    6. Condition 0 /* !((((sizeof (nfsi->open_files.next) == sizeof
(char) || sizeof (nfsi->open_files.next) == sizeof (short)) || sizeof
(nfsi->open_files.next) == sizeof (int)) || sizeof
(nfsi->open_files.next) == sizeof (long)) || sizeof
(nfsi->open_files.next) == sizeof (long long)) */, taking false branch.
    7. Condition 0 /* !!(!__builtin_types_compatible_p() &&
!__builtin_types_compatible_p()) */, taking false branch.
    8. Condition &pos->list != &nfsi->open_files, taking true branch.
    13. Condition 0 /* !((((sizeof (pos->list.next) == sizeof (char) ||
sizeof (pos->list.next) == sizeof (short)) || sizeof (pos->list.next) ==
sizeof (int)) || sizeof (pos->list.next) == sizeof (long)) || sizeof
(pos->list.next) == sizeof (long long)) */, taking false branch.
    14. Condition 0 /* !!(!__builtin_types_compatible_p() &&
!__builtin_types_compatible_p()) */, taking false branch.
    15. Condition &pos->list != &nfsi->open_files, taking true branch.
    20. Condition 0 /* !((((sizeof (pos->list.next) == sizeof (char) ||
sizeof (pos->list.next) == sizeof (short)) || sizeof (pos->list.next) ==
sizeof (int)) || sizeof (pos->list.next) == sizeof (long)) || sizeof
(pos->list.next) == sizeof (long long)) */, taking false branch.
    21. Condition 0 /* !!(!__builtin_types_compatible_p() &&
!__builtin_types_compatible_p()) */, taking false branch.
    22. Condition &pos->list != &nfsi->open_files, taking true branch.
1119        list_for_each_entry_rcu(pos, &nfsi->open_files, list) {
    9. Condition cred != NULL, taking true branch.
    10. Condition cred_fscmp(pos->cred, cred) != 0, taking false branch.
    16. Condition cred != NULL, taking true branch.
    17. Condition cred_fscmp(pos->cred, cred) != 0, taking false branch.
    23. Condition cred != NULL, taking true branch.
    24. Condition cred_fscmp(pos->cred, cred) != 0, taking false branch.

1120                if (cred != NULL && cred_fscmp(pos->cred, cred) != 0)
1121                        continue;

    11. Condition (pos->mode & (3U /* (fmode_t)1 | (fmode_t)2 */)) !=
mode, taking true branch.
    18. Condition (pos->mode & (3U /* (fmode_t)1 | (fmode_t)2 */)) !=
mode, taking true branch.
    25. Condition (pos->mode & (3U /* (fmode_t)1 | (fmode_t)2 */)) !=
mode, taking false branch.
1122                if ((pos->mode & (FMODE_READ|FMODE_WRITE)) != mode)
    12. Continuing loop.
    19. Continuing loop.
1123                        continue;

    Explicit null dereferenced (FORWARD_NULL)
    26. var_deref_model: Passing null pointer &ctx->flags to test_bit,
which dereferences it.

1124                if (!test_bit(NFS_CONTEXT_FILE_OPEN, &ctx->flags))
1125                        continue;
1126                ctx = get_nfs_open_context(pos);
1127                if (ctx)
1128                        break;
1129        }
1130        rcu_read_unlock();
1131        return ctx;
1132 }

Coverity is indicating that the test_bit call on &ctx->flags can cause a
null pointer dereference when ctx is NULL.  I'm not entirely convinced
if this is a false positive, so I though I had better report this issue.

Colin

