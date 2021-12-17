Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70235478546
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 07:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhLQGto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 01:49:44 -0500
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com ([40.107.21.139]:10720
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229757AbhLQGtn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Dec 2021 01:49:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdxlREcOmjzEQDBwOynC4tC60RlhBdRSNd3lVvJmZDiPmZgepG3tGnR39ZA4Ws3A0cuobsRi7t2TM4NYE9EJ726ZGgdARgRC4MhzYUDQx1/VusDsvWFIXWeos5teuB9ubxwMnMQIf6KagpNf02d9BcfaTtlmVUz/s3tN0tjCeL4zQPa76HD43N7Gf9XaATUnWTE8S/nvCmLinCdreMtuKGPjRj8F+uMNyaO4llgYfeDNPcmHxoBvzh9SwNuysnctIb+8ofVYJ+1hvx0+66mG9p3DO7qBhjuImAJZOPcXiUBsDSTnt4Zs9hyzejFk13g8s9BvPhnWiD7PPi+dkK9+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcQfSMXMXaNGvv84bfkYV9JzK7qfWrQQAwsVRZEwsaU=;
 b=KaST1VShAdOiHtqARTFnyL+9xx3akWhlqlAjDCv5gOEOWlVs0pzaiRUhq5BJ6g//KdPz1fWyHHyb9SqlYfLgNuJqy25qpmnFpuqQuQEWCo7iqpTec8fWaEqovvRJG7CsRkltRgSDspJl9/XPxZvMXEucQQG77wgUNrY6SaKuwRon9qmjJ6Dia2l+Ws/+epQ3tvvPf5oaeyS6nP+pbrwQa9GK9INHJX0oYD4ZE7cbfgJrHE4aywYTHMdXfabppGfNEQBrUu1lAE/+3nQh1038UyB2kpK1C6iC4wSftiS5YiURJuDveKDe/2JewRr8cIhk37dZJCCOZMsKKlOwQr//AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcQfSMXMXaNGvv84bfkYV9JzK7qfWrQQAwsVRZEwsaU=;
 b=BhoV0EabcIzh293MzQtaKq/SWm+RWjUFucYgXln+ozP6LWJDpKMhTHiONKywy1dt2X5JUS1FJsJ9elOo+sEbtYcdOSOeka3DFHH+mRCPBfYTkHrkVVgx3XZti/OnSFSWMmsnILxp8Gm1ukJC0J1hs0lTflHUz2AL7GBbnm8UoWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DBBPR08MB6108.eurprd08.prod.outlook.com (2603:10a6:10:1f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 17 Dec
 2021 06:49:41 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 06:49:41 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfsd4: add refcount for nfsd4_blocked_lock
To:     Bruce Fields <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Jeff Layton <jlayton@kernel.org>, kernel@openvz.org,
        linux-nfs@vger.kernel.org
References: <CAPL3RVGBN4SMCBbJcrdgpdZfsfb+AFiHiLhDOFmjkD0ua+XpNQ@mail.gmail.com>
Message-ID: <943cfe47-d48a-4a55-3738-e93370160508@virtuozzo.com>
Date:   Fri, 17 Dec 2021 09:49:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAPL3RVGBN4SMCBbJcrdgpdZfsfb+AFiHiLhDOFmjkD0ua+XpNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0231.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::28) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5d04e5-4a5f-41c8-f967-08d9c1296690
X-MS-TrafficTypeDiagnostic: DBBPR08MB6108:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB6108F427C53D6E47E42169C5AA789@DBBPR08MB6108.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihTEA3HFBGHWOwz2LcKsvSf2KFGKmuWpsntxigQY3M/e7v4oBdK/OMqEBpH0i65woUV0kVYWrrvyy3RlOauRkcYNEFXs8ZreIReH/p73uhCtNU/ZPTmcIngrFFwwF9Gsb1vB7XTOGzaAwIHTCSGNegWnPh4mqNmxNfXlNP7qm+nI+T30oRpg3BVsooUWpq/PnagFIWgTTg3GGkJFaVq89Z0MfUbLFpjxLXWWX2zdyAPtWP9uvWcAw3rhP+nePA4dv5lsfkOvMO/SUcJb4YxjaGEDQErM9gqsnsET+n2D5vsnHNSsZuu04M8yW0L9CArEZp1qtFZQkrNEVtvwsCLX2+FjgW0MpbvJewZAgucOUDw5VswyndbHxY+wtk+gGWuJND2RFcw4ecZkqxeq8u8JCOzH9Z+54lLxxWfOL2OM2Qsvy7wDagWrGEzsuTooag9/6UR3hxJwP4/CzW4eLH/eAQMrsfDv4hWV6VOtAfCFRdDeekSN1G45CoMVGjDB7isKMqHOYewbSRbC72Tmm8Q8tAeTkmlkbQMIKtEyvdZP8LZ0GOCMuEvbub3vdrCgVZfFkx/0b0r0u1elbiiaxB3hwgBTaJfIHBTAg6c1Lba9VyQ8yFqAhJCS4spfoQImbLPLJpNEDYtn85+38QOCIVWrxbbnkBNjhEOLN1HaGvWnP7/fy9t9SUU12Nc2U7o7sGtB9uMC7bg5Mc7UVO2+kplvUkaGrVZBFe1B0GDq1zo72SvbksN8x8s6FU/fhFCY+T5XMCv3PGYP0XzWq2Ap9lR6YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6486002)(6512007)(2616005)(316002)(66946007)(66476007)(66556008)(38100700002)(8936002)(38350700002)(31696002)(4326008)(8676002)(2906002)(508600001)(83380400001)(31686004)(86362001)(36756003)(26005)(52116002)(110136005)(186003)(6506007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NmdGhDMlErZGlTbjZMdlFFREVIalVzN0lmTUlNQzIxSmFTK2ZzVzdETHFK?=
 =?utf-8?B?b1pNNnFKd1Q2VTBQWjVtOERiMGdPWHN3YzVUd3FvRkM3UGdmMWl2b0xFclBa?=
 =?utf-8?B?UzhQWE45K08yWkRyTEtnTDE5WGN4aXR4cE1xaFJkdTBUKzVMeTExbkwrRnE4?=
 =?utf-8?B?a2MxTFQreTRpazFQNUVaRFI1MnhEYzlONzEvMWtFMCtuWTFUeEE0VEpDYmor?=
 =?utf-8?B?ZlQybUNMajhmTmxVcjJNQnliTnNDcmlZakYyeDIxL1p5M20zV3E1azI0eTRu?=
 =?utf-8?B?dG9SYjY3K3pmcE1GWWd5eHRQeU4zbFRBdFhwZ2JjN1ZUamlMN0NNeXFTVWJ4?=
 =?utf-8?B?MkVFZW9EOU5mNVA1WnEwQStaWDZYTkw0YUdZWTZwMzQ4NkdISWtwTGRmd3Z1?=
 =?utf-8?B?UXVUMzBOZTBrOFJ0T0RUREtDUXY5UGxOSGJ0dStsYVloVGlmMFpnTU9rbTU5?=
 =?utf-8?B?c0xPNFlwYWh0VGoyaGkwbmJleUJzci9sZE5QR0lPR3dIQTlLTjZFUHNFS3FN?=
 =?utf-8?B?eEdsVERXaTlsVktPR2lBUjJyZkdIeDRCMDFJdnVhd0laMjZUYkpLamtsV0V0?=
 =?utf-8?B?Z1RCTHlhK1JxMTJzNkEzQ1lHdVdMQlVKdnZrUVpYOUxPMnRqSWM2MXgydGI3?=
 =?utf-8?B?Rlh6bWZCenpUVE9PNVloMGlieDJ5M2tnU0cvcGZXTlBFTjMxSGtTbUxRQWRm?=
 =?utf-8?B?a3dGVStGN2twaXBnUVZFRkcyeW92cXpGbzN4UzBDNEpFbWlkSkpaTnZhTlRv?=
 =?utf-8?B?SnZ3RUFIRVpDYWdXS2xRQURMZ1orOTFibGlEby9wSEFVbW15a3MxeEZKNlFE?=
 =?utf-8?B?SlN2WDR3NXc3N3M4U0JaUkNkTjMwMkFXaWx2NHVKSUkvVXlLQ3dqNTRIYXRI?=
 =?utf-8?B?RGNuaHpGOWNpckRLakNnU2c3TXExa0U2RS9Nc1pFUFhKcDhOYXMxZldvSVJa?=
 =?utf-8?B?NlcyR1R2RGpXSG9uY0hweVRyUWQwRnFhVEV6M1VValhjZkJ1WCt5bzcxa1NF?=
 =?utf-8?B?UzNoUFRxL2s4QkMzTUE0WWJrbzVhV0wyZ1ZBaHZNS25XMXN6UjR6a0Nldk8v?=
 =?utf-8?B?NmlDOE1HYU9GWmEvUmp1K3NwbmhmWjZlaldsR041OWgxSk14ejBSRWdYSmhH?=
 =?utf-8?B?a0M1VUhBUE1yRVg4ZmdjZnNxdk1CSDRYajgwTEhrQzJ6NzZRaFhRd0tzZTJw?=
 =?utf-8?B?SEpvcTZtYmpiRDdicDZOby9UR0ZqYnBOSnd6aldqY3A3OVFzRFlBOVhuYUF5?=
 =?utf-8?B?aWM3TTl5V2hVV0RqR1hEQjV6OHFiU2dWQ0lwam4zWlRISHZHd1ZnSlllMGF1?=
 =?utf-8?B?MytlWStXUlNybU5VbG8rVE1VZ3BKWDExNmtOTkRUd3NkdGkvenNCQisvTXZ2?=
 =?utf-8?B?Mzl2Z1VlTCtELzJhZEhSVElWOG5DR1owNFBnSGFOQ2FoTlpxME5PaEF3KzI0?=
 =?utf-8?B?bSswRHQvS1RsRTBhUVNuZHFVODI2eGhLTmE4V1ZRKzhmRnhlaXBSSC9PSnlD?=
 =?utf-8?B?dWxUNnJyMmtMTFlzSmpyckRZZjFVa3hldVhYWEF0a1cwT1BpbFZOSnA0TnUw?=
 =?utf-8?B?YWhTMXdOV05tNXBJQlJVS0FhbU9vc0t0QTJBOVdhZ29iUkd5czArRlJBc2JH?=
 =?utf-8?B?RXlEaWJYRjR4MzUwL3UyaHlVN3o0ejlUK1lJcFpESnYxRHhXd0J1TlpvOXox?=
 =?utf-8?B?dGVKbFRORHpQeXlJQXpGOG5iQTJldUpnc2orZjJRM0hMWm83VzRuS0ZiTFJm?=
 =?utf-8?B?MFpaVUgyZzRBck1uc0tQMFJCaHBFa1RlNThoYnRqK05wek50d1QwaE9NdXZG?=
 =?utf-8?B?KzI3L0oySHdBZXRRVkxPbnFLMWlMOUVFeXNWNEkrMlVPWExyWmJaR05ZU2Qx?=
 =?utf-8?B?MFcraVFyTnhpcnFrTnY2SVhkQ2RnbEVlRCtXZWhpRWFzTk4yVVRHUDBhaTFa?=
 =?utf-8?B?UGhZRzV0Vmd6c2hlNXRFbmhXYldwWVFmVmhHK25WNzFoaXBHY3BaTUxtbWFW?=
 =?utf-8?B?amxYd09wNFA2dVJueEpHeS9tbHVLUVlPTTkwdEllZFdnbWJCa1o0NXBwNFhG?=
 =?utf-8?B?WGNQdFdrdklyRG4zUmxBVGJURU1hZWdCQnQ0MmRxcmpDTXFCNy9HMnNyZFZ6?=
 =?utf-8?B?L25hb3piTHF3VDRRN2U3dk4rVjFiOXBuYkhpKzNoazVkN3J2MFBHT29ac1dM?=
 =?utf-8?Q?U3y54hwZpomLNSf2L96LhUk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5d04e5-4a5f-41c8-f967-08d9c1296690
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:49:40.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz8SVZO99iMVczn5C4/Dg/sO5nK3TATjqDevY3xmwez73kBsY3UiEQFKYFnts/uy1i3K3rUCc9qA4Sb4iAiL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6108
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nbl allocated in nfsd4_lock can be released by a several ways:
directly in nfsd4_lock(), via nfs4_laundromat(), via another nfs
command RELEASE_LOCKOWNER or via nfsd4_callback.
This structure should be refcounted to be used and released correctly
in all these cases.

Refcount is initialized to 1 during allocation and is incremented
when nbl is added into nbl_list/nbl_lru lists.

Usually nbl is linked into both lists together, so only one refcount
is used for both lists.

However nfsd4_lock() should keep in mind that nbl can be present
in one of lists only. This can happen if nbl was handled already
by nfs4_laundromat/nfsd4_callback/etc.

Refcount is decremented if vfs_lock_file() returns FILE_LOCK_DEFERRED,
because nbl can be handled already by nfs4_laundromat/nfsd4_callback/etc.

Refcount is not changed in find_blocked_lock() because of it reuses counter
released after removing nbl from lists.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++---
 fs/nfsd/state.h     |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d75e1235c4f5..b74f36e9901c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -246,6 +246,7 @@ find_blocked_lock(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 	list_for_each_entry(cur, &lo->lo_blocked, nbl_list) {
 		if (fh_match(fh, &cur->nbl_fh)) {
 			list_del_init(&cur->nbl_list);
+			WARN_ON(list_empty(&cur->nbl_lru));
 			list_del_init(&cur->nbl_lru);
 			found = cur;
 			break;
@@ -271,6 +272,7 @@ find_or_allocate_block(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 			INIT_LIST_HEAD(&nbl->nbl_lru);
 			fh_copy_shallow(&nbl->nbl_fh, fh);
 			locks_init_lock(&nbl->nbl_lock);
+			kref_init(&nbl->nbl_kref);
 			nfsd4_init_cb(&nbl->nbl_cb, lo->lo_owner.so_client,
 					&nfsd4_cb_notify_lock_ops,
 					NFSPROC4_CLNT_CB_NOTIFY_LOCK);
@@ -279,12 +281,21 @@ find_or_allocate_block(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 	return nbl;
 }
 
+static void
+free_nbl(struct kref *kref)
+{
+	struct nfsd4_blocked_lock *nbl;
+
+	nbl = container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
+	kfree(nbl);
+}
+
 static void
 free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 {
 	locks_delete_block(&nbl->nbl_lock);
 	locks_release_private(&nbl->nbl_lock);
-	kfree(nbl);
+	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
 static void
@@ -302,6 +313,7 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
 					struct nfsd4_blocked_lock,
 					nbl_list);
 		list_del_init(&nbl->nbl_list);
+		WARN_ON(list_empty(&nbl->nbl_lru));
 		list_move(&nbl->nbl_lru, &reaplist);
 	}
 	spin_unlock(&nn->blocked_locks_lock);
@@ -6976,6 +6988,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
+		kref_get(&nbl->nbl_kref);
 		spin_unlock(&nn->blocked_locks_lock);
 	}
 
@@ -6988,6 +7001,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			nn->somebody_reclaimed = true;
 		break;
 	case FILE_LOCK_DEFERRED:
+		kref_put(&nbl->nbl_kref, free_nbl);
 		nbl = NULL;
 		fallthrough;
 	case -EAGAIN:		/* conflock holds conflicting lock */
@@ -7008,8 +7022,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		/* dequeue it if we queued it before */
 		if (fl_flags & FL_SLEEP) {
 			spin_lock(&nn->blocked_locks_lock);
-			list_del_init(&nbl->nbl_list);
-			list_del_init(&nbl->nbl_lru);
+			if (!list_empty(&nbl->nbl_list) &&
+			    !list_empty(&nbl->nbl_lru)) {
+				list_del_init(&nbl->nbl_list);
+				list_del_init(&nbl->nbl_lru);
+				kref_put(&nbl->nbl_kref, free_nbl);
+			}
+			/* nbl can use one of lists to be linked to reaplist */
 			spin_unlock(&nn->blocked_locks_lock);
 		}
 		free_blocked_lock(nbl);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e73bdbb1634a..ab61dc102300 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -629,6 +629,7 @@ struct nfsd4_blocked_lock {
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;
+	struct kref		nbl_kref;
 };
 
 struct nfsd4_compound_state;
-- 
2.25.1

