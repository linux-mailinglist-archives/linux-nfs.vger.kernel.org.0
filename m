Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971777C57DD
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjJKPPN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjJKPPN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 11:15:13 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2139.outbound.protection.outlook.com [40.107.102.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2A94
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 08:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed0cQo/C50OXc7HVCQMP8entGDVx47BQU1p01NYgIHksC2SxKJjdGen5qOyR4OZGqO61jt7IiT9hgppJ4s7remT23RYwlewCns51lPIDJ+ZR+nLVIMh+NgEQJ6lvhcDek6PPoiN27wCWbRREFUZ7BRz/W7r8f4i18lgxOfHaBshVTO1P1Li0El7q9eIYwRs0H9eRH9DcgjgPZN+OmRm6cFPhEKiemJeCQ5LlBZumZIB3JVTKnj8WVYY+BQXvbP1XdGOrhJ4Tn5/tvtjok5gZP4q2ql3qU/VugDYnA1X5WoNSJBgv3Ir7RRWD7HqMJiktOsvI5APMalmYYYG4xWSB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IiUSR7XdqunsZqdWoLAXcemu8F20xvDGPrggEcbLBk=;
 b=Ow3A5nVr/IfHXVpEzqaAwALFGzSeH/TPqD2fOVYu9TpLvgZjRLcSjda4NlQsa2Zwg4BZt/a0/8tl2P0ZrYYRofd+oYSEK3Q9lPpRHgs25ZLnQA28vDJ88QN44xw4b6T3IDyKY/n7NIzl3jh3xbpbGSzHj0fzlndKlul6Qmzy3q7BckiZ+wyNjxolQTAU1FEyZQFN7oFdn7D2KQ1n/4ekDVVPqIpQztZ0TawoIEsCUz4g5vmZ2toVI1K+Kx3ytBc3riDuvUOWbFvYrWKF4JtnA341c0kTo2tiBrEPWlvKJK0Dnqk9u2/iyN5+HAiS9PdkbZqjzfXUu+8dD32RccrArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IiUSR7XdqunsZqdWoLAXcemu8F20xvDGPrggEcbLBk=;
 b=ZyMsH6OBRxtYLtCK+rWZeYVaojKRZpJCeJ8kNbxzI+rJb/Lm61/wjKiPPhCCr1YYqqo4U797103zCn7tLg1p3jwzWKPsjYzLwh8iPJqIkxE1HDyNOrXUQOaYEBUVrUaVnjUwLXIJP27kTGUBYv4WIjeUX5fp8o+Nwmd85EW4S5M=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB5275.namprd13.prod.outlook.com (2603:10b6:303:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 15:15:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a927:9364:531e:6924]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a927:9364:531e:6924%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 15:15:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: bpftrace script to monitor tasks that are stuck in NFSv4 exception
 loops
Thread-Topic: bpftrace script to monitor tasks that are stuck in NFSv4
 exception loops
Thread-Index: AQHZ/FW3DFOHpl6yCkG7BbkGJ7G3oA==
Date:   Wed, 11 Oct 2023 15:15:06 +0000
Message-ID: <c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO6PR13MB5275:EE_
x-ms-office365-filtering-correlation-id: 724014d7-bedf-4c6a-33d4-08dbca6cd9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vopeuR3+EMsJrQKcxguHQy5DQ1V3/cTHhp2UrEA4YM53TrAM06TROWI8NmPAl+5ZkObj1Mm84UlU6exTfJ2DcEc+w0A9TSbEoZnPCadE+C8GwU57I4r9RpU9ztqwqkd+4//tiHudeAafqxOksqiZYSUoL2nCmRPPthu2c5Dx4ez9MJxgVmsqA+QKE+ZoRJsm9Br6mUzKbjcJbmMnEu0v7FPt+69rNLfMICr64ftw88YofXsD/p9IGVOhM+m3a7EQWvVfAAglsnr6UgOpNfp1U4Hd6kCqtpzSFTRU5Gnr9T1XEKgIwEq6B5gdCv4te0wdJ24qRxCz0OcvlCWJhr2aavdfUplTPIhdhOgp3mQci5FZ7cxVDFSFfzUQkymZ10YRR3W/8BUPsam3cmK7csjuuEx6DX+cUz8yBN7LdCJpS8y6htFAx/FCDRy1END9X99b3cnqFTQg2h00rWFAcWTqYbUD47lY12cYpU44e+LEaDZ29muoM6EM9G4CKbrfcAyrdhwB2TgKmz7Hn2r2C/1U++mYj4fknPS5D3rF5ubDNMf7CPn+wOPVE88Yh5B5zjHw/G660SIXy4IYM7i601A3Vs66lmC+or+xagUBOI2M4fAMjQJqefdey9IBJ/MrzqQhr6c4HrNOYAB6QsKRSyvGkN9J9FVP1r411rN6sFTdgmzALDboCC3kJsVIBzc8caN8WXKt/e7UzRG3wo4diBtIQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39840400004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(91956017)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(2616005)(38070700005)(558084003)(316002)(6916009)(6506007)(71200400001)(38100700002)(6486002)(2906002)(5660300002)(8676002)(4326008)(478600001)(8936002)(86362001)(99936003)(122000001)(41300700001)(6512007)(36756003)(26005)(15477505002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2NHUnNsUFc2eVpGL2RObEFoRXJ0clhVNkVVcWxIYm5GRW5qY0xwVTVFSjFi?=
 =?utf-8?B?MThVVXN3WE1UbEUxWjJRVEpQUElxN294T3dpamN4bUpncFBGcThueGJyOG9P?=
 =?utf-8?B?SUJlcVBtc1ZmMGU0bVRaOWlHelMyelVYTXpRd3RMTzZwKy9FVEdib3hyTHNB?=
 =?utf-8?B?d3JNWHJveXdFUFUxMEdxSkhaZWE4SDFiR09IWURqWnNzdzFDSzdDRGJnUzR0?=
 =?utf-8?B?VjBFQ0pFZHJHcG1vVFdqS0s3bW80dkpMamtWM2dCcVY0SW5MM2FUN215WUZ3?=
 =?utf-8?B?YndFdkVieERyU0FxMkdWN3g4RGhOcEpqa2VMODMvaDBjb0YvRys3dmZmaHoy?=
 =?utf-8?B?N3E0ZjIzbmorczVVUWJHcWJmQXRYdTI3bTVLZG12YkxzWWFUY1ZkQUlGRVc2?=
 =?utf-8?B?WEtnTkZwekFuSHpxV1JZeStoSWVLeDBMbXoyQnErUTNqc0h6VGVvSzFKaW5s?=
 =?utf-8?B?N3AxK3Rsb1ZMZWVVcXVvWHovMUFSV2pvZDdMT2Z6azJXamJPV1pTSG5ibElJ?=
 =?utf-8?B?K253SDBOanV6U0V4dDF2NHlxOXNNazNnc2t2UjBVcWlESmJFRHhVbGJwY3dw?=
 =?utf-8?B?QjZIK2VQQVNRMXVaNCtjdGxMSW14dENreHJUcE1YTDl3RDc0U1hlQXZ4Qk9Q?=
 =?utf-8?B?c0Q3MDZOL2lybTA1cXd4cUNuWUhUR3JYaWJ1bEF4VEpzQkF5QzVJNTNici9M?=
 =?utf-8?B?TVRJQzhFWlBjTnRkZXFUWWVLS000VTNiWm5JL2xTcWJaR09CODEwY0UwbTNN?=
 =?utf-8?B?ZnJJVGo3d2NmVjN5WEU3L1pHcGhIblRJV2lqZ2o0NjNBbEEzTHZLSk5RRER5?=
 =?utf-8?B?d3BPYUZzSjJUUzRrbVMyLzdjd1R0aGRHdXpSd1l1WFNkRFRxd3pLTkpCb3hQ?=
 =?utf-8?B?dm5TZjM0YzV1WmRvV3RPNUNQeVJ1OTJ0UlBsZlB4V2tnOGEydGtOZ0hHZGpw?=
 =?utf-8?B?RTFqazR4bmFOckZ4VEgwbE9qc1Z1WnY1VW96U2VLMnJ6MkZxVEwrMWxFcHox?=
 =?utf-8?B?cjhBeHRSdWwrLzNqK0tidWhzUWN0MFJtMGJhMVBxekRGS0RXUkRCWmd0K3Rr?=
 =?utf-8?B?N0xYUnFrN0lndEE1M2hrdER5S2xjWW52MndlbUNqZDN4QURJMy93WVFuM3JM?=
 =?utf-8?B?TnRyTWZPeXkrUHZncjd5eHBXaTJFWEtiN3dtSkMzWS91R2NUMlJqZGJaaWNq?=
 =?utf-8?B?QzdaU3BIYTFHNGo3ekdxZzZPRm9lSEtoYkVWc2lWc0YvUUdQRXpFaUMrMnEr?=
 =?utf-8?B?SzM5R2VIUmw1R0xLc3ZGaXNGb1RYT29wTUhwZmVpcitsZitMQmdjWFF1V3Zm?=
 =?utf-8?B?UVIza2FpV3BaNzRoNlpSV2lacnRLR00zWjVDTXpUSUJJQWpBNk9jcnh1Vzky?=
 =?utf-8?B?NjVncFZWc25nQklUK0hvOXBwWExxalFhdEl0cHpHeWhKM2Qzbk12eXNDWldn?=
 =?utf-8?B?WEVNQUNaazdvVmVFZElKeGtRR3doelRWbWRQT2hNZXlNV2RJOFg3NHBxNnUw?=
 =?utf-8?B?ZHVjMkhZYkpvWCtRSVlhdlFIM3h0Y1lSSzR4Qy80cE03U2h4aEhHR0g5bFgx?=
 =?utf-8?B?bnl4MTljVW1GU1B6THhjUUFHS0tnZkVnbWV4NFpIWWN2TDJvTlFEL21CZXQ2?=
 =?utf-8?B?SWhyUk0xblZKZ0R1VWJHWGZGQUtBNUt1THc2VXRFNFh4N3JnQjR3SytjdjE2?=
 =?utf-8?B?MTY0enR0M1JuSnJ0eElYS1drZWNzTStXQkpNblp3OGJ3cWQyUWV4dkt1bDRO?=
 =?utf-8?B?U1h3dGVUdncyTGEwVDFHYXVYaEVmTnlhUXdQSFdFQWxUWjlQR2JmRlJJekVB?=
 =?utf-8?B?Zlp4dURuZEwwa2tUOHVzOUZsaGRIWW4xSzM5SXJ2TkdEaXdlYlR1MVpvc1ZQ?=
 =?utf-8?B?dDRnZmExMWIyQTlQOEZDbGtmYjV1UldGNVdsZFJtUEIwK0dtV3dDaXg1aWha?=
 =?utf-8?B?cW4zTGRlSmpSQUFnSTZVT0FNQ1BNNnJRT1VkdmlCRWZTdHV2WVJOeG9qSm9N?=
 =?utf-8?B?UkpMaTY4ZXRkcmtXQlgrdytOSGR2MDhVSTk0S0t4S1AwSDVEZkZNQ3JVRkQ2?=
 =?utf-8?B?UTJLR202dmEvcjYva1NrRkxoMnpYd0xGZDFJODVodkRiQ1RYbjdKYjM0bExr?=
 =?utf-8?B?alJGM053Q3lCdUxCcFR3UVlkRXFGZ0JRb2dXeWdWVjZMQUxMQlFtZkIrT2h1?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: multipart/mixed;
        boundary="_002_c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7camelhammerspac_"
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724014d7-bedf-4c6a-33d4-08dbca6cd9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 15:15:06.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpTgUhyKX/ws5Ueyzd6A5uoiN5ObhZ1VU7n5sMczICu30EafpfLVVioQGILLpdGxHm0u9soN3F7+HQocMpBgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_002_c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7camelhammerspac_
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A0BE7AB64A48B438FC89F4FF1BF51D5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

U2VlIGF0dGFjaG1lbnQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K

--_002_c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7camelhammerspac_
Content-Type: text/plain; name="nfs4-client-monitor-exceptions"
Content-Description: bpftrace script
Content-Disposition: attachment; filename="nfs4-client-monitor-exceptions";
	size=852; creation-date="Wed, 11 Oct 2023 15:15:05 GMT";
	modification-date="Wed, 11 Oct 2023 15:15:05 GMT"
Content-ID: <D692BF2FA7E96346AD80D4FBAC1397C4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9icGZ0cmFjZQovKgogKiBNb25pdG9yIE5GU3Y0IGV4Y2VwdGlvbnMKICoKICog
Q29weXJpZ2h0IDIwMjMgVHJvbmQgTXlrbGVidXN0CiAqIExpY2Vuc2VkIHVuZGVyIHRoZSBHUEx2
MgogKgogKi8Kc3RydWN0IG5mczRfZXhjZXB0aW9uIHsKCXN0cnVjdCBuZnM0X3N0YXRlICpzdGF0
ZTsKCXN0cnVjdCBpbm9kZSAqaW5vZGU7CglzdHJ1Y3QgbmZzNF9zdGF0ZWlkX3N0cnVjdCAqc3Rh
dGVpZDsKCWxvbmcgdGltZW91dDsKCXVuc2lnbmVkIHNob3J0IHJldHJhbnM7Cgl1bnNpZ25lZCBj
aGFyIHRhc2tfaXNfcHJpdmlsZWdlZCA6IDE7Cgl1bnNpZ25lZCBjaGFyIGRlbGF5IDogMSwKCQkg
ICAgICByZWNvdmVyaW5nIDogMSwKCQkgICAgICByZXRyeSA6IDE7Cglib29sIGludGVycnVwdGli
bGU7Cn07CgprcHJvYmU6bmZzNF9kb19oYW5kbGVfZXhjZXB0aW9uIHsKCSRzZXJ2ZXIgPSAoc3Ry
dWN0IG5mc19zZXJ2ZXIgKilhcmcwOwoJJGVycm9yY29kZSA9IChpbnQzMilhcmcxOwoJJGV4Y2Vw
dGlvbiA9IChzdHJ1Y3QgbmZzNF9leGNlcHRpb24gKilhcmcyOwoJJGlub2RlID0gJGV4Y2VwdGlv
bi0+aW5vZGU7CgoJaWYgKCRlcnJvcmNvZGUgIT0gMCAmJiAkaW5vZGUgIT0gMCkgewoJCSRkZXYg
PSAodWludDMyKSRpbm9kZS0+aV9zYi0+c19kZXY7CgkJcHJpbnRmKCIlcyBbJWRdOiBpbm9kZT0l
dToldToldSwgZXJyb3I9JWQgJXNcbiIsCgkJICAgICAgIHN0cmZ0aW1lKCIlRiAlSDolTTolUyIs
IG5zZWNzKSwgcGlkLCAkZGV2ID4+IDIwLAoJCSAgICAgICAkZGV2ICYgKCgxIDw8IDIwKSAtIDEp
LCAkaW5vZGUtPmlfaW5vLCAkZXJyb3Jjb2RlLAoJCSAgICAgICBrc3RhY2soKSk7Cgl9Cn0K

--_002_c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7camelhammerspac_--
