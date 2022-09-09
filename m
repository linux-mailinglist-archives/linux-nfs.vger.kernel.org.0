Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067155B3D75
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiIIQvq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIIQvR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 12:51:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585A6524A
        for <linux-nfs@vger.kernel.org>; Fri,  9 Sep 2022 09:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epXL5hf9FcATp+fQhfrYZSDk8hWjBOP5NFm3FRGzIuTJLy2GaIvyqilyApq5H6GyZDWOVquEZeBm+17eRU5m3AvZB9/5XLcLbbb3Ck995n73Ndo2zo61PfIy64LoRSZvzxcmxLgvO9JUov+PzxkW0/C2kiHyhSuRlYcRq5YGmlHFVATvjkClFYUbVLIL8I2HL0jRxEqwzUkCUcMaTWnlJBI8DOQn8q1manHr3nnRNRSFBRyyx6wOnDzt8DwZAqDGAw+PJkepH1rTC7LXiAM/KJ2P1SyCZjwixNzaMyApq7Pvd11axgYrgA9UuyoioO++ueIp0DcmeqWz5GXGxKVobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by7pRTp9HSsI9YBzU/qxbpVC7PIYauobA3ibqEStLQc=;
 b=DfHwtCIw1UGDXj2aeH687sgFA5nJ7h4M20jfp6zNd+rI8jaM1uYUWwt9kcs+gZL5iVNMvgH6mvI/5QrGgbmHn7qEXluuFkHxQOORxznQ4++tIt70t9a0o5pfjEoC8Uua6+DFHiQ3Qax/OGrJ8G8CQ1cEXcemhbb2H4SYLgYM4XD9SHc564Mx8rWQ+aGFL+2cyZOuKzceqrm3qLQBvlIWywV1knQ7SicwT4ybMSMQg0DHrA5r5ZC3jLxYeKvdV0/IqtFRLlMOyIiSXfS7xNOnKCBngAVwlYIyDdtKxGobM3xhCapN9CDw9KYGLPssnr8IoLt+e5aiSvgeB1RDHfP33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by7pRTp9HSsI9YBzU/qxbpVC7PIYauobA3ibqEStLQc=;
 b=TRgAcg/flOtkOfhHh4Awm3Mcs1HKnDbtaCFWsJispQDjqULBqCoZxo5zJU6OcqYDYPbZlgImmeG+GiVpOJu6CwhUn/LsYI0f2SuQIF4rx3cTUCFc/FonCwiNxZV64NdEkc8IZ/gprNrG6BKoBWj3nME6qX/h7JLYAutKceT06wo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5410.namprd13.prod.outlook.com (2603:10b6:303:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.7; Fri, 9 Sep
 2022 16:50:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.006; Fri, 9 Sep 2022
 16:50:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "igor@gooddata.com" <igor@gooddata.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
Thread-Topic: Regression: deadlock in io_schedule / nfs_writepage_locked
Thread-Index: AQHYtf93d5SRXUGPYkyFYNes7xsaQa2686EAgAALV4CAAAUVgIAcTFgAgAAay32AAAF1AA==
Date:   Fri, 9 Sep 2022 16:50:54 +0000
Message-ID: <a3aa0865d7c6e5b0f8f3dfd62e99578fc528eab0.camel@hammerspace.com>
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
         <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
         <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com>
         <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
         <CA+9S74iB8kjqcySajgfbcFGt5nrL3YpquWc66oL5mvnPgO3vnA@mail.gmail.com>
         <CH0PR13MB50840DBE3BF030039288DB63B8439@CH0PR13MB5084.namprd13.prod.outlook.com>
In-Reply-To: <CH0PR13MB50840DBE3BF030039288DB63B8439@CH0PR13MB5084.namprd13.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW4PR13MB5410:EE_
x-ms-office365-filtering-correlation-id: 7b187655-fdfa-403e-aa2a-08da92837608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cCDATmPIPmjshtzaktA/KxphfJi8Xn0DwSB/9D+7f8tx/BRv/v8rxZ2fEuG+lOU5adOUaBN7PHU1OfjUWY04E9ApLR6zbEPRoYBCl6V05sMLTJkLCDvx/eDRZ5+NFHiMMGsKqvRXic33j6XMYPXp3u3cvSDDeTpI+miMzkWHBKt7d3hfAIBbgsXXdbaNwCI9oWcRIoy39E4l9XpSAYEgeQvUeGR5FsG0nOTgNo0EMyR7MxHBl9k9KRY/0QDzG9zF+9tjMkyPQdWgR9OLCSKie3vzO/5OQAHwmjTZvjgM90ih5YLNOGkRDhzdj5tj3cD2FYmFZ/6jFRWg8A79gb1yrZWGiAUQpN93ghtfxUMMWIDZgDfkByRDYNZ6w6+jxbnKr/ioDlhxpN/qRrnkB7Ci51ZBOwoQYeDnLnA90JmS22AATEjfcZ8zsgn7caC4wRBhaNzKFQ9NjSLMxA5m3KhcaiZhs0NYK63AL2l96OqXsDXfIUEP6wZX9ONVFxpzkVeosSUSuqnIZVdFMn7MwWMm0fV3+7d1UCdd1qWIcffD8uVsHnBPi9+bJCrLYObkb+dIF7HaIhKBcW4nVsclth1TTei4PlLysGleUBwgOhABs/d+kXP/rmB/jHIK0aflIXzhu0hV+krzbCnZZZn6UJp1ogrrZvHreztKmTrdcp3AD36d89Yw5XNqHUnmY2BVeib+fVYwYGUbevthKVj3vpCwgX8slNjl4hXrH0/XyROus/cxVHRec/YCrQ+9J+z23p55PF+hqEBshdK8r+JvjfksG1RBbia6/VQ7WeveT3oyso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(39840400004)(366004)(966005)(6916009)(316002)(54906003)(6486002)(186003)(478600001)(83380400001)(36756003)(2616005)(86362001)(2906002)(41300700001)(4326008)(26005)(64756008)(66946007)(6506007)(66556008)(76116006)(66476007)(122000001)(8676002)(38070700005)(8936002)(53546011)(66446008)(71200400001)(38100700002)(6512007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2g3Y09TcnVlTW53Rlc5RmQ5WjdqazJjcGxoNGJzZGwreDZITEJuMzlvVXNT?=
 =?utf-8?B?alg4VEhJZFRmeUtqM2RvU0NYYmxtV1B4QmJpc0djTzdDWSt2YWtVeWh6MWZo?=
 =?utf-8?B?LzdLUm50OWFSM1d3a0ZqQWxrL2g4cDZHY3RTU0w0UEtGajhzL2dpc0RjbkM1?=
 =?utf-8?B?NkVlNTNWaTZkcFU2YUpSK1ZZbnJBSWlYMEdNdCtoYTNCTTc0TzJYWTluemhP?=
 =?utf-8?B?bW4rTjlrRGkwWnV5ODNqYUR2cDlWcVJOOGt0OFlHd3RPdnRxSlpFc1U0U2Rn?=
 =?utf-8?B?UDgxN2Y2aXovazk2dzNueS8veHlmUHZucGRzNldwOXZxQmpvVlVEQmF3S3Ir?=
 =?utf-8?B?eXdWOXRoNk1RY0U2ZzJ2YS9TVVkrbXQ0LzlsZHA2RWtVQU1EdUN0L01HbjZP?=
 =?utf-8?B?eGdKYS9Ybnk1TVRVaWIvWUxOWmRPMWkweFZIRHB5SjJvOG9sM3I1NmFJVVBy?=
 =?utf-8?B?d3p1SzhmS1U3dzV4Z3FmOG1RNkVnbldPUlhIdXZNTnpGeWZ1ZFZZVG1oQXpR?=
 =?utf-8?B?QkJrU2tLdU1XU3VwYk1LcWZSak9iYWljeG9TY01ZQi8vR3YrTDd4QWhUcEVm?=
 =?utf-8?B?Rjg5ajZRYmg5Y0w4MU9tT2piQnJIV0VIQ0cyMktwVzZUMWg2emE5eW8vNkMw?=
 =?utf-8?B?TC9PaXNCcFozUzRsNHNacHB5VllCNVFkQlQ5VzcxSUc4NXZaVUdFOXlURzky?=
 =?utf-8?B?SFBCbWZJM21IYnpTTXhOYnZCVlVjY2p4KzhrUjdrejU5ZDRDNVc4OGtZQ3Q5?=
 =?utf-8?B?dDhDazVJc0o0YTAzay9ZQ0RFeEtzM3lZQmVLRXpFZ0F5SkgrV0FoRjVwc1hz?=
 =?utf-8?B?QS9RUHNtekZUU1pXMDZZTUdKRnE5Mi9tbXdRTE9OMlhScTBEQ2duYU90YmFM?=
 =?utf-8?B?YnUzK0Q4WHRUdm1Rczl0WTE3TW5UcC80bGVwcmd6a1NuVGJSNDBVc0tkWStU?=
 =?utf-8?B?UUhxUENCdWlkaXZqRHQ1SzlSZ2Y3ekJvN2hWaEpiZ3NDSm1sZzVzK1lvMlh5?=
 =?utf-8?B?RXZtV2RrMFlzbDVKcDJJMHYxNmRaWWNTQWxMVm8vOW14bGdXc25IbUZFY2Jz?=
 =?utf-8?B?cjRjWERpK00xblplZUE4SUR4K2FOMVJPdTNsd3hJblkxREtUOU0xUDhmNVZU?=
 =?utf-8?B?MWpQNFJVMCtjanBMc0wxT2pjdGZLeG5tdHJFeHdzYjZZcmpabERPb2pNZEwr?=
 =?utf-8?B?YXN1eDFEemNnOERYZG16TFNBVTYxeFl6ZUc1ZGRFNkpwSnljUWpQOTR6c0V0?=
 =?utf-8?B?NlgxYXk4WlF3cVJyWlBOS25MSUtiZVJUdmNsdW83RWlVMllpUWpTWkQ5dHF4?=
 =?utf-8?B?WjhmTHFPeHExL1pDM3ROTUNtK3h6WmdWWXNNSnJLUW5ocU5HSEo1VWQvWHVo?=
 =?utf-8?B?c0x1Z20xK3FxaGlCV2NaNHZRRGNCeFR3TnBEaW80TTRZYlErR2pGOTdqWnJt?=
 =?utf-8?B?dlVpU1R5VjNlaHdGdUI2MG5CTVppVktDNGF4R3hjVmtPa3c0anFYUEduSjBI?=
 =?utf-8?B?RTBWZ25HZHdud2lzcGluRHhKS2pZZHhDTmVVTjd5SG16eldCQm5mUGxkOXha?=
 =?utf-8?B?emMvNE4wajFuZlgyR2VFbGpVN3ZYVGVwalFBa0kwdDlyRXl3NkpxdGV5aVR6?=
 =?utf-8?B?ckhERGlPeW5lWVpqeFBDSDVPU3B6bXdOcjc0VEN6SkhzZVRRamViZlVWZXVx?=
 =?utf-8?B?QWJyWVJ6SklMWXBJSlpvMnR4L2xZWUxaNHlETlVzQUkvTkhicnFuOWdkQ3FI?=
 =?utf-8?B?cWJoWlZwdHk4bnRrZm11SHAyY05HY2k5U1BwN3ZUSUgrRHZuOHA4S0VYd0hI?=
 =?utf-8?B?dEM2bGtHRFdZOHo2RXdJdjNmdUszbjVPZEFJUENQZDZIQU1QM28yNHdkSmQ5?=
 =?utf-8?B?MGh0QlJkRDhhMVNkcG5XZFNWYXNmRzM0cERzSkRSMzdhTXd3T3cyalIrb3c3?=
 =?utf-8?B?YTJCUjR0UW5sNEl3V2tGanZwUHh1SmUvMCs5bE41MTA4bHVWMG40alIza095?=
 =?utf-8?B?c2FaU3ZXU2ZxU05QZFFpT2J2MUM5cS9UUCtGRWxTVXJZNFdYQUdiSDJlZHIw?=
 =?utf-8?B?dWJ5SDcxd2U5aFVYUkUyMnNVUmw2QmpTNWpSVUF1RHVubkFsWDhibmtndTEy?=
 =?utf-8?B?aHEvUVg0RHlBcUVuY3hFa3lHN2RISitWUXNJRlZXRTBzK2M3MWZSRU40Zzl4?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECCEB929BD58D4BA9D40119CCECE89A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDE2OjQ3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IFRoaXMgbG9va3MgbGlrZSBpdCBtaWdodCBiZSB0aGUgcm9vdCBjYXVzZSBpc3N1ZS4gSXQg
bG9va3PCoGxpa2UNCj4geW91J3JlIHVzaW5nIHBORlM6DQo+IA0KPiAvcHJvYy8zMjc4ODIyL3N0
YWNrOg0KPiBbPDA+XSBwbmZzX3VwZGF0ZV9sYXlvdXQrMHg2MDMvMHhlZDAgW25mc3Y0XQ0KPiBb
PDA+XSBmbF9wbmZzX3VwZGF0ZV9sYXlvdXQuY29uc3Rwcm9wLjE4KzB4MjMvMHgxZTANCj4gW25m
c19sYXlvdXRfbmZzdjQxX2ZpbGVzXQ0KPiBbPDA+XSBmaWxlbGF5b3V0X3BnX2luaXRfd3JpdGUr
MHgzYS8weDcwIFtuZnNfbGF5b3V0X25mc3Y0MV9maWxlc10NCj4gWzwwPl0gX19uZnNfcGFnZWlv
X2FkZF9yZXF1ZXN0KzB4Mjk0LzB4NDcwIFtuZnNdDQo+IFs8MD5dIG5mc19wYWdlaW9fYWRkX3Jl
cXVlc3RfbWlycm9yKzB4MmYvMHg0MCBbbmZzXQ0KPiBbPDA+XSBuZnNfcGFnZWlvX2FkZF9yZXF1
ZXN0KzB4MjAwLzB4MmQwIFtuZnNdDQo+IFs8MD5dIG5mc19wYWdlX2FzeW5jX2ZsdXNoKzB4MTIw
LzB4MzEwIFtuZnNdDQo+IFs8MD5dIG5mc193cml0ZXBhZ2VzX2NhbGxiYWNrKzB4NWIvMHhjMCBb
bmZzXQ0KPiBbPDA+XSB3cml0ZV9jYWNoZV9wYWdlcysweDE4Ny8weDRkMA0KPiBbPDA+XSBuZnNf
d3JpdGVwYWdlcysweGUxLzB4MjAwIFtuZnNdDQo+IFs8MD5dIGRvX3dyaXRlcGFnZXMrMHhkMi8w
eDFiMA0KPiBbPDA+XSBfX3dyaXRlYmFja19zaW5nbGVfaW5vZGUrMHg0MS8weDM2MA0KPiBbPDA+
XSB3cml0ZWJhY2tfc2JfaW5vZGVzKzB4MWYwLzB4NDYwDQo+IFs8MD5dIF9fd3JpdGViYWNrX2lu
b2Rlc193YisweDVmLzB4ZDANCj4gWzwwPl0gd2Jfd3JpdGViYWNrKzB4MjM1LzB4MmQwDQo+IFs8
MD5dIHdiX3dvcmtmbisweDMxMi8weDRhMA0KPiBbPDA+XSBwcm9jZXNzX29uZV93b3JrKzB4MWM1
LzB4MzkwDQo+IFs8MD5dIHdvcmtlcl90aHJlYWQrMHgzMC8weDM2MA0KPiBbPDA+XSBrdGhyZWFk
KzB4ZDcvMHgxMDANCj4gWzwwPl0gcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4gDQo+IFdoYXQg
aXMgdGhlIHBORlMgc2VydmVyIHlvdSBhcmUgcnVubmluZyBhZ2FpbnN0PyBJIHNlZSB5b3UncmUg
dXNpbmcNCj4gdGhlIGZpbGVzIHBORlMgbGF5b3V0IHR5cGUsIHNvIGlzIHRoaXMgYSBOZXRBcHA/
DQo+IA0KDQpTb3JyeSBmb3IgdGhlIEhUTUwgc3BhbS4uLiBSZXNlbmRpbmcgd2l0aCBhbGwgdGhh
dCBjcmFwIHN0cmlwcGVkIG91dC4NCg0KPiBGcm9tOiBJZ29yIFJhaXRzIDxpZ29yQGdvb2RkYXRh
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgOSwgMjAyMiAxMTowOQ0KPiBUbzogVHJv
bmQgTXlrbGVidXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4NCj4gQ2M6IGFubmFAa2VybmVs
Lm9yZyA8YW5uYUBrZXJuZWwub3JnPjsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiA8bGlu
dXgtbmZzQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFJlZ3Jlc3Npb246IGRlYWRs
b2NrIGluIGlvX3NjaGVkdWxlIC8NCj4gbmZzX3dyaXRlcGFnZV9sb2NrZWQNCj4gwqANCj4gSGVs
bG8gVHJvbmQsDQo+IA0KPiBPbiBNb24sIEF1ZyAyMiwgMjAyMiBhdCA1OjAxIFBNIFRyb25kIE15
a2xlYnVzdA0KPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9u
IE1vbiwgMjAyMi0wOC0yMiBhdCAxNjo0MyArMDIwMCwgSWdvciBSYWl0cyB3cm90ZToNCj4gPiA+
IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gaWdvckBnb29kZGF0YS5jb20uIExlYXJu
IHdoeSB0aGlzDQo+ID4gPiBpcw0KPiA+ID4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xl
YXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+ID4gPiANCj4gPiA+IEhlbGxvIFRyb25k
LA0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIEF1ZyAyMiwgMjAyMiBhdCA0OjAyIFBNIFRyb25kIE15
a2xlYnVzdA0KPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4g
DQo+ID4gPiA+IE9uIE1vbiwgMjAyMi0wOC0yMiBhdCAxMDoxNiArMDIwMCwgSWdvciBSYWl0cyB3
cm90ZToNCj4gPiA+ID4gPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGlnb3JAZ29v
ZGRhdGEuY29tLiBMZWFybiB3aHkNCj4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gaXMNCj4gPiA+
ID4gPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uIF0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIZWxsbyBldmVyeW9uZSwNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBIb3BlZnVsbHkgSSdtIHNlbmRpbmcgdGhpcyB0byB0aGUgcmlnaHQgcGxh
Y2XigKYNCj4gPiA+ID4gPiBXZSByZWNlbnRseSBzdGFydGVkIHRvIHNlZSB0aGUgZm9sbG93aW5n
IHN0YWNrdHJhY2UgcXVpdGUNCj4gPiA+ID4gPiBvZnRlbg0KPiA+ID4gPiA+IG9uDQo+ID4gPiA+
ID4gb3VyDQo+ID4gPiA+ID4gVk1zIHRoYXQgYXJlIHVzaW5nIE5GUyBleHRlbnNpdmVseSAoSSB0
aGluayBhZnRlciB1cGdyYWRpbmcNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IDUuMTguMTErLCBi
dXQgbm90IHN1cmUgd2hlbiBleGFjdGx5LiBGb3Igc3VyZSBpdCBoYXBwZW5zIG9uDQo+ID4gPiA+
ID4gNS4xOC4xNSk6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSU5GTzogdGFzayBrd29ya2VyL3Uz
NjoxMDozNzc2OTEgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMg0KPiA+ID4gPiA+IHNlY29uZHMu
DQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBUYWludGVkOiBHwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBF
wqDCoMKgwqAgNS4xOC4xNS0xLmdkYy5lbDgueDg2XzY0ICMxDQo+ID4gPiA+ID4gImVjaG8gMCA+
IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMNCj4gPiA+
ID4gPiB0aGlzDQo+ID4gPiA+ID4gbWVzc2FnZS4NCj4gPiA+ID4gPiB0YXNrOmt3b3JrZXIvdTM2
OjEwwqAgc3RhdGU6RCBzdGFjazrCoMKgwqAgMCBwaWQ6Mzc3NjkxIHBwaWQ6wqDCoMKgwqANCj4g
PiA+ID4gPiAyDQo+ID4gPiA+ID4gZmxhZ3M6MHgwMDAwNDAwMA0KPiA+ID4gPiA+IFdvcmtxdWV1
ZTogd3JpdGViYWNrIHdiX3dvcmtmbiAoZmx1c2gtMDozMDgpDQo+ID4gPiA+ID4gQ2FsbCBUcmFj
ZToNCj4gPiA+ID4gPiA8VEFTSz4NCj4gPiA+ID4gPiBfX3NjaGVkdWxlKzB4MzhjLzB4N2QwDQo+
ID4gPiA+ID4gc2NoZWR1bGUrMHg0MS8weGIwDQo+ID4gPiA+ID4gaW9fc2NoZWR1bGUrMHgxMi8w
eDQwDQo+ID4gPiA+ID4gX19mb2xpb19sb2NrKzB4MTEwLzB4MjYwDQo+ID4gPiA+ID4gPyBmaWxl
bWFwX2FsbG9jX2ZvbGlvKzB4OTAvMHg5MA0KPiA+ID4gPiA+IHdyaXRlX2NhY2hlX3BhZ2VzKzB4
MWUzLzB4NGQwDQo+ID4gPiA+ID4gPyBuZnNfd3JpdGVwYWdlX2xvY2tlZCsweDFkMC8weDFkMCBb
bmZzXQ0KPiA+ID4gPiA+IG5mc193cml0ZXBhZ2VzKzB4ZTEvMHgyMDAgW25mc10NCj4gPiA+ID4g
PiBkb193cml0ZXBhZ2VzKzB4ZDIvMHgxYjANCj4gPiA+ID4gPiA/IGNoZWNrX3ByZWVtcHRfY3Vy
cisweDQ3LzB4NzANCj4gPiA+ID4gPiA/IHR0d3VfZG9fd2FrZXVwKzB4MTcvMHgxODANCj4gPiA+
ID4gPiBfX3dyaXRlYmFja19zaW5nbGVfaW5vZGUrMHg0MS8weDM2MA0KPiA+ID4gPiA+IHdyaXRl
YmFja19zYl9pbm9kZXMrMHgxZjAvMHg0NjANCj4gPiA+ID4gPiBfX3dyaXRlYmFja19pbm9kZXNf
d2IrMHg1Zi8weGQwDQo+ID4gPiA+ID4gd2Jfd3JpdGViYWNrKzB4MjM1LzB4MmQwDQo+ID4gPiA+
ID4gd2Jfd29ya2ZuKzB4MzQ4LzB4NGEwDQo+ID4gPiA+ID4gPyBwdXRfcHJldl90YXNrX2ZhaXIr
MHgxYi8weDMwDQo+ID4gPiA+ID4gPyBwaWNrX25leHRfdGFzaysweDg0LzB4OTQwDQo+ID4gPiA+
ID4gPyBfX3VwZGF0ZV9pZGxlX2NvcmUrMHgxYi8weGIwDQo+ID4gPiA+ID4gcHJvY2Vzc19vbmVf
d29yaysweDFjNS8weDM5MA0KPiA+ID4gPiA+IHdvcmtlcl90aHJlYWQrMHgzMC8weDM2MA0KPiA+
ID4gPiA+ID8gcHJvY2Vzc19vbmVfd29yaysweDM5MC8weDM5MA0KPiA+ID4gPiA+IGt0aHJlYWQr
MHhkNy8weDEwMA0KPiA+ID4gPiA+ID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhpdCsweDIwLzB4
MjANCj4gPiA+ID4gPiByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KPiA+ID4gPiA+IDwvVEFTSz4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIHNlZSB0aGF0IHNvbWV0aGluZyB2ZXJ5IHNpbWlsYXIg
d2FzIGZpeGVkIGluIGJ0cmZzDQo+ID4gPiA+ID4gKA0KPiA+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWkN
Cj4gPiA+ID4gPiB0Lz9oPWxpbnV4LQ0KPiA+ID4gPiA+IDUuMTgueSZpZD05NTM1ZWMzNzFkNzQx
ZmEwMzdlMzdlZGRjMGE1YjI1YmE4MmQwMDI3KQ0KPiA+ID4gPiA+IGJ1dCBJIGNvdWxkIG5vdCBm
aW5kIGFueXRoaW5nIHNpbWlsYXIgZm9yIE5GUy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEbyB5
b3UgaGFwcGVuIHRvIGtub3cgaWYgdGhpcyBpcyBhbHJlYWR5IGZpeGVkPyBJZiBzbywgd291bGQN
Cj4gPiA+ID4gPiB5b3UNCj4gPiA+ID4gPiBtaW5kDQo+ID4gPiA+ID4gc2hhcmluZyBzb21lIGNv
bW1pdHM/IElmIG5vdCwgY291bGQgeW91IGhlbHAgZ2V0dGluZyB0aGlzDQo+ID4gPiA+ID4gYWRk
cmVzc2VkPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHN0YWNrIHRyYWNlIHlv
dSBzaG93IGFib3ZlIGlzbid0IHBhcnRpY3VsYXJseSBoZWxwZnVsIGZvcg0KPiA+ID4gPiBkaWFn
bm9zaW5nIHdoYXQgdGhlIHByb2JsZW0gaXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBBbGwgaXQgaXMg
c2F5aW5nIGlzIHRoYXQgJ3RocmVhZCBBJyBpcyB3YWl0aW5nIHRvIHRha2UgYSBwYWdlDQo+ID4g
PiA+IGxvY2sNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiBpcyBiZWluZyBoZWxkIGJ5IGEgZGlmZmVy
ZW50ICd0aHJlYWQgQicuIFdpdGhvdXQgaW5mb3JtYXRpb24gb24NCj4gPiA+ID4gd2hhdA0KPiA+
ID4gPiAndGhyZWFkIEInIGlzIGRvaW5nLCBhbmQgd2h5IGl0IGlzbid0IHJlbGVhc2luZyB0aGUg
bG9jaywgdGhlcmUNCj4gPiA+ID4gaXMNCj4gPiA+ID4gbm90aGluZyB3ZSBjYW4gY29uY2x1ZGUu
DQo+ID4gPiANCj4gPiA+IERvIHlvdSBoYXZlIHNvbWUgaGludCBob3cgdG8gZGVidWcgdGhpcyBp
c3N1ZSBmdXJ0aGVyICh3aGVuIGl0DQo+ID4gPiBoYXBwZW5zDQo+ID4gPiBhZ2Fpbik/IFdvdWxk
IGB2aXJzaCBkdW1wYCB0byBnZXQgYSBtZW1vcnkgZHVtcCBhbmQgdGhlbiBzb21lDQo+ID4gPiBr
aW5kIG9mDQo+ID4gPiAiYnQgYWxsIiB2aWEgY3Jhc2ggaGVscCB0byBnZXQgbW9yZSBpbmZvcm1h
dGlvbj8NCj4gPiA+IE9yIHNvbWV0aGluZyBlbHNlPw0KPiA+ID4gDQo+ID4gPiBUaGFua3MgaW4g
YWR2YW5jZSENCj4gPiA+IC0tDQo+ID4gPiBJZ29yIFJhaXRzDQo+ID4gDQo+ID4gUGxlYXNlIHRy
eSBydW5uaW5nIHRoZSBmb2xsb3dpbmcgdHdvIGxpbmVzIG9mICdiYXNoJyBzY3JpcHQgYXMNCj4g
PiByb290Og0KPiA+IA0KPiA+IChmb3IgdHQgaW4gJChncmVwIC1sICduZnNbXmRdJyAvcHJvYy8q
L3N0YWNrKTsgZG8gZWNobyAiJHt0dH06IjsNCj4gPiBjYXQgJHt0dH07IGVjaG87IGRvbmUpID4v
dG1wL25mc190aHJlYWRzLnR4dA0KPiA+IA0KPiA+IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9zdW5y
cGMvcnBjX2NsbnQvKi90YXNrcyA+IC90bXAvcnBjX3Rhc2tzLnR4dA0KPiA+IA0KPiA+IGFuZCB0
aGVuIHNlbmQgdXMgdGhlIG91dHB1dCBmcm9tIHRoZSB0d28gZmlsZXMgL3RtcC9uZnNfdGhyZWFk
cy50eHQNCj4gPiBhbmQNCj4gPiAvdG1wL3JwY190YXNrcy50eHQuDQo+ID4gDQo+ID4gVGhlIGZp
bGUgbmZzX3RocmVhZHMudHh0IGdpdmVzIHVzIGEgZnVsbCBzZXQgb2Ygc3RhY2sgdHJhY2VzIGZy
b20NCj4gPiBhbGwNCj4gPiBwcm9jZXNzZXMgdGhhdCBhcmUgY3VycmVudGx5IGluIHRoZSBORlMg
Y2xpZW50IGNvZGUuIFNvIGl0IHNob3VsZA0KPiA+IGNvbnRhaW4gYm90aCB0aGUgc3RhY2sgdHJh
Y2UgZnJvbSB5b3VyICd0aHJlYWQgQScgYWJvdmUsIGFuZCB0aGUNCj4gPiB0cmFjZXMNCj4gPiBm
cm9tIGFsbCBjYW5kaWRhdGVzIGZvciB0aGUgJ3RocmVhZCBCJyBwcm9jZXNzIHRoYXQgaXMgY2F1
c2luZyB0aGUNCj4gPiBibG9ja2FnZS4NCj4gPiBUaGUgZmlsZSBycGNfdGFza3MudHh0IGdpdmVz
IHVzIHRoZSBzdGF0dXMgb2YgYW55IFJQQyBjYWxscyB0aGF0DQo+ID4gbWlnaHQNCj4gPiBiZSBv
dXRzdGFuZGluZyBhbmQgbWlnaHQgaGVscCBkaWFnbm9zZSBhbnkgaXNzdWVzIHdpdGggdGhlIFRD
UA0KPiA+IGNvbm5lY3Rpb24uDQo+ID4gDQo+ID4gVGhhdCBzaG91bGQgdGhlcmVmb3JlIGdpdmUg
dXMgYSBiZXR0ZXIgc3RhcnRpbmcgcG9pbnQgZm9yIHJvb3QNCj4gPiBjYXVzaW5nDQo+ID4gdGhl
IHByb2JsZW0uDQo+IA0KPiBUaGUgcnBjX3Rhc2tzIGlzIGVtcHR5IGJ1dCBJIGdvdCBuZnNfdGhy
ZWFkcyBmcm9tIHRoZSBtb21lbnQgaXQgaXMNCj4gc3R1Y2sgKHNlZSBhdHRhY2hlZCBmaWxlKS4N
Cj4gDQo+IEl0IHN0aWxsIGhhcHBlbnMgd2l0aCA1LjE5LjMsIDUuMTkuNi4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
