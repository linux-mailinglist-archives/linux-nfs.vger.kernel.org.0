Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326DC1EA05E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFAIzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jun 2020 04:55:03 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com ([40.107.2.134]:12383
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFAIzC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Jun 2020 04:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKqCmrR3xqyJPfftwccx7bw6WixFr93YueDOyGtNCe+M9Dognpqy5OYyLdvcKDtc89kbVbYBU4SHMZZfHCxcCdlQR7aZTmOuUmp0TLpBF4EDc4SnkRboIMpJZgp3TLquQCJmh5o6SN0yU7c9u3kdEvRhEh3WU/3F8YhyZKCkhB0kUt/vJZGH01jOdjD9DwHsDvCjuDs1K2IldWgIG8aDfsfc7wtNeJgG4Nid+l1L0ezO6fQtyildA+lCWp6c7i3ALsZbP46o1YI+KJUAoV2KfH4YQQvbLWmSLmEIA2TZVFVdTPuB0w2KqnzDQ99n7GgxZlYgBFan3+Y44E8374JKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ON2b0UGD3CBWnONtXMbnANpwfJbBpnEXDaJZhTqdk=;
 b=JCmVnejsT99Jy7FhfgF8jrXf/S5l4wVlFaSvfNG4I2chQrZA/Xh4ZE+paLfZj6By92Jb/n3OQWZFTlQHFE8WkGVpBkEOZBrTTLR55MaxAr8XlKIVvNSRaf4BoLSiMAgbDmdbbyJ5vG5Ok6tCjUOuSYp1y3qVQAO9k8L/TMNfKBglixLgAyGo1sd2GtR4LO4BV2lv26TUJ0qyz2f8TJp9qXC9z1d1oO0LmxRPvIvls2x+f54QytiwhAINIeTmP8sK/j998MyTf2Sq0JvyYzS38ugpbYMX17YJVFm6HOXDPWB2Z5UY/a512sDV8dwG37yGy1UYqFwq0iuJ2FXmPdj1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ON2b0UGD3CBWnONtXMbnANpwfJbBpnEXDaJZhTqdk=;
 b=X9ZPv0OB6voOBqTdcB8nYqwAS8hI4ozpUppfVpajNO/xtZLa9Ct5t/mTKkSDKNTsctCWmLrBwYmN9R+aMGM0xnAscB5tdinl22MoSUV6klk2EcMoH1kl/rn0tb/FcRmBF5tIeOULD1jT5oqEOrH5+/aHe4E4HDmG8aOV51WlIPw=
Authentication-Results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB3202.eurprd08.prod.outlook.com (2603:10a6:208:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 08:54:59 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2%6]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 08:54:59 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] sunrpc: fixed rollback in rpc_gssd_dummy_populate()
To:     linux-nfs@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <dc913496-1c07-fa86-9019-52fd5dcc878a@virtuozzo.com>
Date:   Mon, 1 Jun 2020 11:54:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM4PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:200:89::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 08:54:58 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 888cb34a-edff-4706-5258-08d8060976eb
X-MS-TrafficTypeDiagnostic: AM0PR08MB3202:
X-Microsoft-Antispam-PRVS: <AM0PR08MB32023F376E0D7B448C6B5C9FAA8A0@AM0PR08MB3202.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGhqie/xXVwmaIrZ7rjoDY9Kw1PGYwx1GP/1xjwTJADGvA7/Sk/sBt0G9cemNKHIWky343MVbmczBp6OycKWYxWgB3glF8dDBXaa2i04tj9v+NwrfNQqFJNdJrr5gTYuJMO3p6TRrQSQ/k2Z2Zbt+Y7y/KZpQ0vbY39KVeKVzTLWoZkertjB/1epuG4ivgmiQf6rSB1uu28i6sw6r8lxQLOdKp3IwiiXTtGmgbFNfU6qlEwP05o52DQS5cB5tU1RV7y4e3R/xZ7qpJq4S7hAdAHOGm6SvPg75Fj+diPufdLcMCRrO646WK2LgeHbKxri9rU6WgdgEiAoHLQzosUzkKK9hxhancTCOOI9FV5/YnnBKM8PrrJfaf6jznbm95/S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39840400004)(366004)(346002)(396003)(376002)(4326008)(31686004)(52116002)(66476007)(66556008)(4744005)(36756003)(6486002)(5660300002)(66946007)(6916009)(186003)(16526019)(2906002)(86362001)(478600001)(31696002)(316002)(8676002)(16576012)(956004)(26005)(8936002)(2616005)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bCgfPPfLzm6NJm34n/V0Y9ofMzhe/AXullwgszpUU/PBP93K4b+d/GkLwIcZHJp0+1fKaLnusSUOP0CCjCit1ay6h61uceUVrZWNYJeUpy9GQUXl51CpvMhVsNUYjftllDBqhPHCObxaINoIpmWYyRB+FzCDjO4xPyMKRUuw7/6QUVXKoaVbNWcHP43XMlgqG6EY4ovjF0YIAp+7ox2fVE/5KUE08NuHAskLh8v0d9hUrf+GTh4g59HRrUsd4Ea7Z/Sl0Kt12izQd+1pFEcWnwTmr+i4Uta1DbgewtAcw8JnkCmWeflBqnHYA5tUBMJ8zX8gBFOmL4QBNnRtCfqKmDaSaInrkLepw61xMAVd/BppiQI2qV/wwRQWSnffyCnknHcUULoXRG+1gGHrKQwSMiQ/0i7iFh0tEqvHDcohm9IPTWUJwHslXmDFVG2E5+wn0HkapNyP9DrWc9fbo8z/xeyXHETUxfXfshuj9wakA7A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888cb34a-edff-4706-5258-08d8060976eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 08:54:59.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+w7mRueQPFmKjx2JxHP0TbWVHZ9rV7jnGns26a3uNHLQHZQ+u4/N3p0OV81pEj0bJDyuguDsIDsZLdJMEPSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3202
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

__rpc_depopulate(gssd_dentry) was lost on error path

cc: stable@vger.kernel.org
Fixes: commit 4b9a445e3eeb ("sunrpc: create a new dummy pipe for gssd to hold open")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 net/sunrpc/rpc_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 39e14d5..e9d0953 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1317,6 +1317,7 @@ void rpc_put_sb_net(const struct net *net)
 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
 	if (!clnt_dentry) {
+		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
 		goto out;
 	}
-- 
1.8.3.1

