Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510BF4D52F5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Mar 2022 21:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiCJUQK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Mar 2022 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCJUQJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Mar 2022 15:16:09 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2116.outbound.protection.outlook.com [40.107.96.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315CBFABEA
        for <linux-nfs@vger.kernel.org>; Thu, 10 Mar 2022 12:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcIZlLFBnyfG9cOEUMYofmJLhVLbH/pyvSJYhxWhiZjvEM7g2AKmwF3Zy5AKfAENUa8WvmCZsVnTidbdNonki1QutXS6cvBqvW+XW/BhOLdkrrvz1Ni8wDvBDLK1cmzwp9rzAUKDzi5bZBYXHpsIqNmY5aRlH0NlI4fM56Zo8zw8k/JUN9aJhY5dJb29VWRIdvc6/q5T5mKesHgZqvyBoSPZQQ/Mk4eh6MscFOllbaDNqH7FB8TgZtotlClm3k6kYT5ESe5LPyKtqAOt3011Ek1LDZI7g5KohEw5SVcGhIW4Xgr4poDO3aSxKusnoOTOH2nsoTVIGHydk1V+uYQVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov+V/2GbcgxK4X7Vs8tNBfydpg/jzF/nRVDgcjhmeHA=;
 b=SdVvkWDQqhZuHcZzKHHXt+Z31qGDf03Qd0iTfV4gFtgaQQpxncCn0Y7w0H7OUuXGLF3OPVfU3sJ01+o62fZUEaBfPHRGiQeSEYXzVlxlaFoqKmniF4Q+eMznGMT5AUMWYKSKPfQrkCzuP9ME9NpceTiJaGDj6LVOuRDwzaYuig2si0/1DhaaSdwrinWTF6pKBVlzGrqm02FJLytlfEB1LN5O4MwCJVUNzJg6yEObA+b848hB4WybdizTGlowuFMEsfNGyUPx3QmoRoFjT/NI65G2X2OHrTiJlD00K4YVvVQCkwKqnQ0yNNnZ1I9pmmtAiZM9SERuc01tqMFo9emd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov+V/2GbcgxK4X7Vs8tNBfydpg/jzF/nRVDgcjhmeHA=;
 b=aQZUqmLSUDh4YkMC4t+K6DlC0qynSZKN69JM0dQOvrSyqU3vDiwTQFgMWUXKnvt2e0IfnnVQWNTOkylwni3ETZesM33o5uhUA/yG4ETJQArkMbiLLXqfOinERk9CmbxIv10gCUlHm49p9uqvWE1gK3m9tunT/dgC/5eThTFkUqw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4131.namprd13.prod.outlook.com (2603:10b6:5:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7; Thu, 10 Mar
 2022 20:15:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%7]) with mapi id 15.20.5061.018; Thu, 10 Mar 2022
 20:15:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v9 14/27] NFS: Improve heuristic for readdirplus
Thread-Topic: [PATCH v9 14/27] NFS: Improve heuristic for readdirplus
Thread-Index: AQHYLDBf36N/8FLwKUCGz73+bm+obqy3YPqAgAG9sQA=
Date:   Thu, 10 Mar 2022 20:15:04 +0000
Message-ID: <28d6a094ddca6e4e6c15e055ec3ef6b10d57cbd3.camel@hammerspace.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
         <20220227231227.9038-2-trondmy@kernel.org>
         <20220227231227.9038-3-trondmy@kernel.org>
         <20220227231227.9038-4-trondmy@kernel.org>
         <20220227231227.9038-5-trondmy@kernel.org>
         <20220227231227.9038-6-trondmy@kernel.org>
         <20220227231227.9038-7-trondmy@kernel.org>
         <20220227231227.9038-8-trondmy@kernel.org>
         <20220227231227.9038-9-trondmy@kernel.org>
         <20220227231227.9038-10-trondmy@kernel.org>
         <20220227231227.9038-11-trondmy@kernel.org>
         <20220227231227.9038-12-trondmy@kernel.org>
         <20220227231227.9038-13-trondmy@kernel.org>
         <20220227231227.9038-14-trondmy@kernel.org>
         <20220227231227.9038-15-trondmy@kernel.org>
         <A7BBBBF2-768E-487C-A890-7E5AF1D40027@redhat.com>
In-Reply-To: <A7BBBBF2-768E-487C-A890-7E5AF1D40027@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ccd2bc9-6382-462d-83dd-08da02d2aa25
x-ms-traffictypediagnostic: DM6PR13MB4131:EE_
x-microsoft-antispam-prvs: <DM6PR13MB41316400148FB438157223FEB80B9@DM6PR13MB4131.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Q6kPmbIoE9gFjeA+ycUnv+8UhMazPlsPv3kqFxKBkNC9g1soHVIJE8EoHe+cMYiqKy7Kh7osPE6LkrVlYGSqr+067eFqVfDEEMcK7BUCjsoC656yYyDtRUh3TO+LiwKwdCJ5Dm0OPOxPNlAH/hKJPSKQzthdA+ZVfNviCcwvTkiLcX0w6qRJpCLdo4k4B37VaN36pdJZXR1FG0IdiRSkGntvz7WPufn6/vb29fiixagVcB+9OYOETe3k2Zn9LzeUdIF6+xCfhA2pZbOHWQetOnpHBHN/j+yZIYaQX++PcMpeE2vRH5p2pkz3UzqGuL1lkTNTgOzDGoUe+xY4p9X5xX+cC9Yto6veGblUbHKHy4ghAwasX4XMzuXiyTFL7pCwn4bjPrF4zf1DCsh+NPHS3DqcWp/kRFFUugSrh3Zaeek41+6ssH2XkuExpZPONKhLIE7usu644A+H0Jwya1K1WaxxWHLrXkjbi4lN7ChiZMLHWR54T0Ea2MK3DuWMQjCWGVuhdYEKPzXN8xB6Uoana6YWKL2uPHXArmNklFqUCLTtq5RU3dZO/McU7kRJ4CzTkO4MAiLn8BSYmqklYEcBfKQNjmPmAi/X4q5qcgGbWNMMbTqC+j86RXLLk7tJXVlT9D6XnXb5+CZH1STtPbE4z+PSD56GZNK4JBdkYBePVDt34rfMZDv3/GeeAgwjG5Wc2KHQPutnC7vXiGSVWfbDpZCmwb1pcaR2jmr+RrT7IcSeBPaXW1ZH7bgOUsKCCEz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6486002)(53546011)(6916009)(6506007)(4326008)(66476007)(508600001)(36756003)(76116006)(64756008)(316002)(66556008)(8676002)(66946007)(66446008)(6512007)(5660300002)(2906002)(2616005)(38070700005)(71200400001)(83380400001)(122000001)(38100700002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUdodm1tODdONVg4VFpkaWFKdURNWFE1NjdxZTZmRnVsMjFlaStaTDdMbDlz?=
 =?utf-8?B?WmkwRWtnSlFPMlc5aFVFeGdzN3BMK1VLb2NOZWEyNGpPbjhVSTUvaG1IdVNn?=
 =?utf-8?B?SXZ5SnpWVkwvVnNGUi91Tm0rei9PYjl1Sm1GUkl2cFdpTUtOSXlDdk9QeGdM?=
 =?utf-8?B?RGdMZ0pHeTFlYm5pWUJadkk1aTBaMG81OEdQbWlld0JxSXd2ZkxITUFVdDFp?=
 =?utf-8?B?TEViM04yam93TUx2OXJ4eGRNQ0ErMldic2pvSXR6SG9Kbnh2RzRYUFBuR1dL?=
 =?utf-8?B?dHlqSExSOGZoblluM01FdFBBYVJ0WGZzcXM3WWFyVkxSUWhDTDIrRjNyTnRs?=
 =?utf-8?B?UHpSa3RmUDZHb0RXVUVYOEEvYWFWSUFPRjJXTEFJWFJqSnVwOEJLZm5vaERn?=
 =?utf-8?B?eUVzNGxFUFh4WUoyc3BSbnRQeXNYaXc1bWc2OGlqSVBMZWVCTk1pekFGQVNB?=
 =?utf-8?B?R3dORkIxUmxac2FUUDYvVWFGa0Y2MTR3V2IzRkZnZHN5U0dlZmNhR1RzNUcx?=
 =?utf-8?B?ZkxobzZWYXFDNnltUE1zd1JJdUJqNTNIRUEvZzhrSFQyYnIrSm05aFRVNllG?=
 =?utf-8?B?Nkdyd09CbTJLTzlpcmZoKythR0NmeWZhaFlKS2pjaktFcHFBZ1ZPZXdzN2My?=
 =?utf-8?B?a3N1NU5XM1pJQ2xRb04rSTgrZDVIU2JYTWdSTFE5dmpvLzRINmJZZ0ZXVEg4?=
 =?utf-8?B?clRBRWFTb3p1dzlPN0VhZ25IU3NiSndrWHkwYW9rdDVZVWxWYVFkMklmNG5p?=
 =?utf-8?B?UGg4ZllJMVhtRzU1NUFPQ1RocHE5Z0paLzZOY0xtM1FKNzFadWcwcW1BMzVs?=
 =?utf-8?B?QjNTTzRmU3k1Y041bVVUWXhUQ0pxM2ZBa2kxNnN2WDIvY2dIYkFTaFoya24z?=
 =?utf-8?B?THNMUWJVdHNQT0JvSXBISi9mSHZtb1l4WW00TnRiV1o0VmJFd0ZnWnUyUkxN?=
 =?utf-8?B?SWFEVmd2T0ZaWjdqTGxzSXlLWVZVV0VPVjJDaVh3TUtnTVZabEdZTW0vYjdZ?=
 =?utf-8?B?a2xoa1FqZkN1c1VETThvSXBYVlpXbmhobUNocGVmQ01oR1JRWml0TWRPRDZK?=
 =?utf-8?B?eXVvOEczVFIyKzQ4OW5yNWtDcUs2WnEydXp5NDV1bXZBZElUZ2JyeURXY0Fj?=
 =?utf-8?B?eXA3N05hdEkzWEhITzI0Vzg1MEhtR1F4QzEwbUlER2pYVDVrY3VOUWxnNVBo?=
 =?utf-8?B?ZmtCQ2RHYVAvdWY3V2dObXNmZ09teEJXNzEzaEZBV0s5bEp4S2FXanJUcWtF?=
 =?utf-8?B?dnRnVFNuOUU2NFNNK0F3WXVtd3pvQU1wK1dMUnF1eTJsYTBUL2Y1ZzlVMjZI?=
 =?utf-8?B?bmRhcFNCeHBtQ29uRkY0YXAya3hsaitwWHlEalNNbXNoSXNYS1VNN3RmQitw?=
 =?utf-8?B?U3FaTWxURndXUFViTHA5NEh3U21aOUg0bXRoREJGbmcwZnBpb3pmdmdORTN6?=
 =?utf-8?B?MzhaR3JibjNPNFFrNS9ieVRsZ290NW9sSmdFWEhxcVRaRnV4VGZ0RDhTcHFK?=
 =?utf-8?B?cVdReUsyak4yc3dlNHBYTTVnTFVNaDRWQ0oydmljdmZNRkM4WmZxaHllY2Vm?=
 =?utf-8?B?ZlAzMDB3TkJaYVc1djBTMEovbjg4VkdnV2p0TjUyWkRiZ29kVzdMekFyYzls?=
 =?utf-8?B?d05KZFVicWRBalg4Tll1cUY0ejM5VCsyK3h6TUhyTnlCVmQ0NzE2Um5aRThY?=
 =?utf-8?B?VWhDT0dRZkp1U1U1RlQxK0lrMjhtWGhkLzNIVFpiNSs0YitzTDJWekZDeFJI?=
 =?utf-8?B?cUVZMkRUVHhsOWdUMHhDUmtuOHBML0hpRlJXNHp2ZHo1SW9XREFvMlc3S2Z4?=
 =?utf-8?B?SHBrZ2pFYXpZWWZGY3pTY3VrVDlMN2VucVFVSGtYSVdmLzNHMzIvVVZpOWtx?=
 =?utf-8?B?T0F5K3NTWXZWSWRpekgrMnJrZGJ2cEJLaUhxa3Y0RTRKeWl2eW4vU3djaks2?=
 =?utf-8?B?aFJYQ3BZR0hrbkhZdFFLaXh1VGo4ZWY2ZDNRV0hYSEQwMXJLcWEzRzEybmlJ?=
 =?utf-8?B?TThTdW8reUFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FA6B995ABA0D3498CC8D1F93179F324@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd2bc9-6382-462d-83dd-08da02d2aa25
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 20:15:04.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3w2EqVu5K9d+fI53sbdvMCZBA0F3s/kGY9ExCzog3bF7Vcbh1PVkN6fkEPXq0V30gfzfhZ0KZZi9YVeQ2NMQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTA5IGF0IDEyOjM5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNyBGZWIgMjAyMiwgYXQgMTg6MTIsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3Jv
dGU6DQo+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbT4NCj4gPiANCj4gPiBUaGUgaGV1cmlzdGljIGZvciByZWFkZGlycGx1cyBpcyBk
ZXNpZ25lZCB0byB0cnkgdG8gZGV0ZWN0ICdscyAtbCcNCj4gPiBhbmQNCj4gPiBzaW1pbGFyIHBh
dHRlcm5zLiBJdCBkb2VzIHNvIGJ5IGxvb2tpbmcgZm9yIGNhY2hlIGhpdC9taXNzIHBhdHRlcm5z
DQo+ID4gaW4NCj4gPiBib3RoIHRoZSBhdHRyaWJ1dGUgY2FjaGUgYW5kIGluIHRoZSBkY2FjaGUg
b2YgdGhlIGZpbGVzIGluIGEgZ2l2ZW4NCj4gPiBkaXJlY3RvcnksIGFuZCB0aGVuIHNldHMgYSBm
bGFnIGZvciB0aGUgcmVhZGRpcnBsdXMgY29kZSB0bw0KPiA+IGludGVycHJldC4NCj4gPiANCj4g
PiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBhIHNpbmdsZSBhdHRyaWJ1
dGUgb3IgZGNhY2hlDQo+ID4gbWlzcw0KPiA+IGNhbiBjYXVzZSB0aGUgTkZTIGNvZGUgdG8gZm9y
Y2UgYSByZWZyZXNoIG9mIHRoZSBhdHRyaWJ1dGVzIGZvciB0aGUNCj4gPiBlbnRpcmUgc2V0IG9m
IGZpbGVzIGNvbnRhaW5lZCBpbiB0aGUgZGlyZWN0b3J5Lg0KPiA+IA0KPiA+IFRvIGJlIGFibGUg
dG8gbWFrZSBhIG1vcmUgbnVhbmNlZCBkZWNpc2lvbiwgbGV0J3Mgc2FtcGxlIHRoZSBudW1iZXIN
Cj4gPiBvZg0KPiA+IGhpdHMgYW5kIG1pc3NlcyBpbiB0aGUgc2V0IG9mIG9wZW4gZGlyZWN0b3J5
IGRlc2NyaXB0b3JzLiBUaGF0DQo+ID4gYWxsb3dzIHVzDQo+ID4gdG8gc2V0IHRocmVzaG9sZHMg
YXQgd2hpY2ggd2Ugc3RhcnQgcHJlZmVycmluZyBSRUFERElSUExVUyBvdmVyDQo+ID4gcmVndWxh
cg0KPiA+IFJFQURESVIsIG9yIGF0IHdoaWNoIHdlIHN0YXJ0IHRvIGZvcmNlIGEgcmUtcmVhZCBv
ZiB0aGUgcmVtYWluaW5nDQo+ID4gcmVhZGRpciBjYWNoZSB1c2luZyBSRUFERElSUExVUy4NCj4g
DQo+IEkgbGlrZSB0aGlzIHBhdGNoIHZlcnkgbXVjaC4NCj4gDQo+IFRoZSBoZXVyaXN0aWMgZG9l
c24ndCBraWNrLWluIHVudGlsICJscyAtbCIgbWFrZXMgaXRzIHNlY29uZCBjYWxsDQo+IGludG8N
Cj4gbmZzX3JlYWRkaXIoKSwgYW5kIGZvciBteSBmaWxlbmFtZXMgd2l0aCA4IGNoYXJzLCB0aGF0
IG1lYW5zIHRoYXQNCj4gdGhlcmUgYXJlDQo+IGFib3V0IDU4MDAgR0VUQVRUUnMgZ2VuZXJhdGVk
IGJlZm9yZSB3ZSBjbGVhbiB0aGUgY2FjaGUgdG8gZG8gbW9yZQ0KPiBSRUFERElSUExVUy7CoCBU
aGF0J3MgYSBsYXJnZSBudW1iZXIgdG8gY29tcG91bmQgb24gY29ubmVjdGlvbg0KPiBsYXRlbmN5
Lg0KPiANCj4gV2UndmUgYWxyZWFkeSBnb3Qgc29tZSBjb21wbGFpbnRzIHRoYXQgZm9saydzIDJu
ZCAibHMgLWwiIHRha2VzICJzbw0KPiBtdWNoDQo+IGxvbmdlciIgYWZ0ZXIgMWEzNGM4YzlhNDll
Lg0KPiANCj4gQ2FuIHdlIHBvc3NpYmx5IGxpbWl0IG91ciBmaXJzdCBwYXNzIHRocm91Z2ggbmZz
X3JlYWRkaXIoKSBzbyB0aGF0DQo+IHRoZQ0KPiBoZXVyaXN0aWMgdGFrZXMgZWZmZWN0IHNvb25l
cj8NCj4gDQoNClRoZSBwcm9ibGVtIGlzIHJlYWxseSB0aGF0ICdscycgKG9yIHBvc3NpYmx5IGds
aWJjKSBpcyBwYXNzaW5nIGluIGENCnByZXR0eSBodWdlIGJ1ZmZlciB0byB0aGUgZ2V0ZGVudHMo
KSBzeXN0ZW0gY2FsbC4NCg0KT24gbXkgc2V0dXAsIHRoYXQgYnVmZmVyIGFwcGVhcnMgdG8gYmUg
ODBLIGluIHNpemUuIFNvIHdoYXQgaGFwcGVucyBpcw0KdGhhdCB3ZSBnZXQgdGhhdCBmaXJzdCBn
ZXRkZW50cygpIGNhbGwsIGFuZCBzbyB3ZSBmaWxsIHRoZSA4MEsgYnVmZmVyDQp3aXRoIGFzIG1h
bnkgZmlsZXMgYXMgd2lsbCBmaXQuIFRoYXQgY2FuIHF1aWNrbHkgcnVuIGludG8gc2V2ZXJhbA0K
dGhvdXNhbmQgZW50cmllcywgaWYgdGhlIGZpbGVuYW1lcyBhcmUgcmVsYXRpdmVseSBzaG9ydC4N
Cg0KVGhlbiAnbHMnIGdvZXMgdGhyb3VnaCB0aGUgY29udGVudHMgYW5kIGRvZXMgYSBzdGF0KCkg
KG9yIGEgc3RhdHgoKSkgb24NCmVhY2ggZW50cnksIGFuZCBzbyB3ZSByZWNvcmQgdGhlIHN0YXRp
c3RpY3MuIEhvd2V2ZXIgdGhhdCBtZWFucyB0aG9zZQ0KZmlyc3Qgc2V2ZXJhbCB0aG91c2FuZCBl
bnRyaWVzIGFyZSBpbmRlZWQgZ29pbmcgdG8gdXNlIGNhY2hlZCBkYXRhLCBvcg0KZm9yY2UgR0VU
QVRUUiB0byBnbyBvbiB0aGUgd2lyZS4gV2Ugb25seSBzdGFydCB1c2luZyBmb3JjZWQgcmVhZGRp
cnBsdXMNCm9uIHRoZSBzZWNvbmQgcGFzcy4NCg0KWWVzLCBJIHN1cHBvc2Ugd2UgY291bGQgbGlt
aXQgZ2V0ZGVudHMoKSB0byBpZ25vcmUgdGhlIGJ1ZmZlciBzaXplLCBhbmQNCmp1c3QgcmV0dXJu
IGZld2VyIGVudHJpZXMsIGhvd2V2ZXIgd2hhdCdzIHRoZSAicmlnaHQiIHNpemUgaW4gdGhhdA0K
Y2FzZT8NCk1vcmUgdG8gdGhlIHBvaW50LCBob3cgbXVjaCBwYWluIGFyZSB3ZSBnb2luZyB0byBh
Y2NlcHQgYmVmb3JlIHdlIGdpdmUNCnVwIHRyeWluZyB0aGVzZSBhc3NvcnRlZCBoZXVyaXN0aWNz
LCBhbmQganVzdCBkZWZpbmUgYSByZWFkZGlycGx1cygpDQpzeXN0ZW0gY2FsbCBtb2RlbGxlZCBv
biBzdGF0eCgpPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
