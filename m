Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0D7F0142
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKRRDb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 12:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRRDa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 12:03:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373AC11D
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 09:03:27 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGaYEO026185;
        Sat, 18 Nov 2023 17:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6y/o0dDrYLteWDXltzIqvBjvOve7wqoBTDHaYiZwuzo=;
 b=Yxrl0EyQshWVrqhHyserhNIi7O6RoxP3BQIkUWkqss9DOQfsFvjcFmTAXje12UdEm+yj
 S4kpmfVDtVqXzoDog3dltCbz/xhfS5mYPTr4fXJDhQ25NOwyrcKjDP5mQzcy5/Izos79
 KTz2blIJY1XazpfK7v2g79njfO6oR9DyL2iWokYxASkWRBLnKmCeEb8+HK7jtHQT/4rH
 tWRs5etp0zjwjPZMms/chJ8Da1lFz1SgsQ3TntIscO1jpxrFIaq+B6SfzJZuazfqnH1i
 tot3eZ7h49llZrzyIhFXjNkaqQiBsgb/8Xn8PQottq434FCxwThFFZrQvO08RItXkoi8 Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2rj2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 17:03:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIChmiH037453;
        Sat, 18 Nov 2023 17:03:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq3kweh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 17:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl2rYtJIZ00hUY14c7f9xDsOslbwqer9uEj8s6OIpPMKYYO4A4aH120mL6UuOhUJ6GMiJdlR8TX8nbKKzufW7HzQvPbiZQF7IuY9KrofduRUKKTn79w8cAX7KYEPliHFFYWVJygzLv7fGgxOcSy0Z0c5y6hVlK4h3JAXDxjdsbwjVAPH/SIgyLiQJzK+PWcZQq7xlxL+AHuUh+VmTTBIKbSDHHzVbb8g6rGD2WykYF1VKjE49Xj1k7kdOfbUrjiS4BgQCYmPE5TGMrqnTuf05JVoxdjZpY8JcKmfHywvZCmBSu/W2T61HCP2yZAHAM+ulJ8cz2JBo4seiVtCzHMGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y/o0dDrYLteWDXltzIqvBjvOve7wqoBTDHaYiZwuzo=;
 b=kGZ1tlEJtJUvEvlfhluNhKz19isC/6AOR3OwPoKaTg/4X1sEc5ZDcyAIvvV6lGz9vWqbYmJ5nT+fTRO4yH6GHUu4OmCucUzQYMysxBeszpWU8ffCEWgpFg/c2L2ExxsGVJFLGYcANy7cpHzumvEs3Uv/+2s+Eh37cpyiiy87cf5FhKnyv0wNlLPX2NHdaayH3i7ztH/dcxozYNkMuawlO4Gb23H6Ee9Hq8HeM00jmAPZmD10DJvFp0uZllhw5iZz1BW+jkVoNJP6kr/VHMVBD2lcnW3M23phpSw9bqDmJQCelWMFXAchJK0RbJz0Kgv+5ow5NXu1/avvHYCi6icagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y/o0dDrYLteWDXltzIqvBjvOve7wqoBTDHaYiZwuzo=;
 b=ovL/nRFCxyiwR7F2C2YzMERiLtcwTQWIUF6koNK3nZupgFoT14WXfeLduPIBLqO49Z3XLmBB6BJMI7BrPzY+s26b0bblAGBHrJj0hgJ0olynw9ouXk3ZDsMvyOmjJra0kcarqfMmZEl2rmMsIZeHnFgM5QsR8adalM34VOYjHcc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 17:03:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 17:03:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qA
Date:   Sat, 18 Nov 2023 17:03:21 +0000
Message-ID: <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
In-Reply-To: <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4932:EE_
x-ms-office365-filtering-correlation-id: 64aa6e1f-ec1a-4ee0-c29d-08dbe8584517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDs1ZPBhCtlLjjFjIwQmr67MPipvautiWsNSFL0Ss1ineSMsiEMfgagl3lsLff55uoMIQ4GE7ehDXXsLi7Ryb/lXhR0FVp37W9GGLG/mg9taZLeVPRUEqg4gijaHzlANGCNtDWqh7EUfqreBIsRfwJGmEjIvNd6ddQ9y8nNG0cpKWC3skzXtr7bJSF/NWzvHi8UquVTWjs25j2dlHzzI4oNEvOZlD/roOyHAZmn0NvwGRi1D9z3ZR6XljLojgXnXcjXzLw8geTpjNgdE6Opn8g0Qzx73On8/z1FC9brKzPynVF+jQB6InGnuXu4ul7ySO+Xk5Omp4YcFjsnakuMGYxv66QcjcbbEipDn6aSwJt2Bt77cREKig0ei3q5wO+G0eorgcmvbkodBZHXsftjVqndW5B9fZUrNp/yP7mPP3ObLfJUAlKmr80mBSfHS4HGbtcsOepOfX0GzQ2YHVC06Z4Ri4oTyZxtcVfzpmjpb9D+as5j9rrwSd+v0icxl4I6CxzFF9uvMfCM9JSCjuMGbptDwSoHMVAUO9+93asOYutoQHWA1m9ShY3XfRublfb/Fs2fE9BCvBGCQCk0UUwa81B1wkyOUi4IU8jJWLkHAErzfCQE6Y0blpp0Q02B4wgTwdrtmSCeMCfh7XPI8MDsK6AzWtTVt0UGIlO+MztD075/b1ZchNnhf5/XKq1SyaAicHBONnx9eE9iWV2wb//qQqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(4001150100001)(15650500001)(122000001)(6486002)(38100700002)(38070700009)(86362001)(33656002)(36756003)(83380400001)(6512007)(53546011)(6506007)(26005)(2616005)(478600001)(71200400001)(41300700001)(8676002)(8936002)(4326008)(76116006)(66556008)(66946007)(91956017)(316002)(64756008)(66476007)(66446008)(6916009)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFCZ3BPLzRkSndUbjVsVjNvL0Z0VEZzbE1UN2ovSTRXbXBHQVBTSjlXYlR0?=
 =?utf-8?B?R1BGR0Q5cWZmSU5VU2h0Q25nTXVsMmI3Y0FsQU93OStKZDhJUDVVWFMyT3F4?=
 =?utf-8?B?K0duYk5zZXNMNmY0cDhoZFNZM3ptNjJJZmdlMno3Tis4UkVPc3dTdW5HTTh4?=
 =?utf-8?B?RUhQMHFlKzExVFpBNGNza0ZKS3Y1UmtRNEVleFl0dmpYaXd2Q2lXU1RyUk1j?=
 =?utf-8?B?R1hXeHVsaXZVQjl4WnFtUC9RdWNLb2FId1JhZ2xmbzJOT1ZzbWdyc3M0SzZP?=
 =?utf-8?B?YkU2ck94NWtsUTVVejJYcFQxVU54dG9DTkpOMDZwY0dlTkl2Zkg0RFNnQ2xC?=
 =?utf-8?B?Rkc4L3JZZ0NGTkRONlBndmw0dWRNU213MS9yVU9CajhibEJNNWVsSVpVdnVU?=
 =?utf-8?B?UW5IaFlXYS8wN1F6ank2eFhpRC92NGVXK0MzTHQ1aDdFbmIrVmlDYVR2Mjd3?=
 =?utf-8?B?YXdlQ1AvLzB5enBXOXBqUU1XV1J4R1hUUU1QTjI5MkZWdTczS0xYTm9zRi9L?=
 =?utf-8?B?a0FrVzdKWnBxcXRQcDJqWTJVenFJeTliSWNTcGw0TjdjK2d1SGlNNzcwTDBa?=
 =?utf-8?B?RGxLWkF5Tnl6Z1Urc1IvODFyNWVCZmlkVzdBMGtWajNFVFlHN25ZR3Z2eVVi?=
 =?utf-8?B?a2lLRXBpV1AvRlVQS3llcmd2U1YvbVNYTFFZREdQZ2JhdkdBemNadkhlc3F2?=
 =?utf-8?B?UjJhZ3NvaVF0eXhCK3BXd1hSOWZteVJXNGdkdkRpelFhbk51WE1NMzFUc2VL?=
 =?utf-8?B?YnY3V09sd1RWcXIvNlYvYlZabkpMTTRwb1BZV1F1a3NnalJwQUUzWk8rRGtz?=
 =?utf-8?B?Ykw4RmR2M0VYRTNDUS9uazRNMFFIVmN0Y2FUMEs3dHZmTGl4b2xsMTkyd0tW?=
 =?utf-8?B?Sll4QlQzQzBDaHNNV3NLRGFwc1ZCaWVya3NuWEU5T2NWVFdXcTZab0NtQTZo?=
 =?utf-8?B?aU9kTkN5bGgvRVIyZFdpY053cGJHNEdGR3piVkhzM0NLSm40U1dIV0FRMm1a?=
 =?utf-8?B?MlgvS3NWMUpMZTV6aHY3OWJKQ1BOM090eHdlWFVSUzJObCtTTjRmeDVISVQ0?=
 =?utf-8?B?Qmp0a2pjdmxuWkF4T2JCYmVLMW9WMUhHMW9CSk5ZRkVBZmNrMy9tUDV5MTYw?=
 =?utf-8?B?R0pTMUJHSzBHUHUxVE9URnFuUVZxektURURNaDRSUFFXQ3drcDhyODVaVGcx?=
 =?utf-8?B?ZzEzVEJtb2l6aHZnNEpBaUd0VDJJQlQwa2NqMXFIMjlLY3M4c2xadEVXdW8w?=
 =?utf-8?B?YVNVL3lVbFR4RDNaSUJoaWQ4ayswQUt0aW9zdXNBdTZKYmRDak04bG9MNUtB?=
 =?utf-8?B?Z29CMXNCa3c0R2ZVMzRvMytIdWU3RVUwOXVVVGpqYkttV3RhRWZvUFRTTEZO?=
 =?utf-8?B?emFtWDY5Q2MvNnJtclJvUldzVWtGcEt2R1VxNGhDZXlsQmhqSnMvMktKai9S?=
 =?utf-8?B?ZUs2ZExocEh0TE1acUpxRXUxZXhtVCtWZmlVdmY5ZkduYjBDY3JVdXpxVVNH?=
 =?utf-8?B?cGR4ejlVbTN6ai9SY09RbmRjU2l0dzd3ZXAzWEdpdEhnS1ErdFNLMDU0MnBR?=
 =?utf-8?B?VjlQUWdVSXdJeXJOTy9QTSs2U0FBcEJVaXU3TmVGUWg0clVIZzJxMitGQjBE?=
 =?utf-8?B?UW5lRzFKSkFmc3B2Z1p1SXVXUWtRNXQwNlhqc1lLOTBwNEFtZXF2aVIwQXFv?=
 =?utf-8?B?M1BoKzgzRWN2Q3JPL0lhUzAyVGxYR3cvOURxNEpsdWVVb2Fwa0cwTVc2TUtm?=
 =?utf-8?B?NWQ4L0ZzRlI4WkJFY0JSUWp4OFpmenpFSENJNTVrNUJkOERRQm5SeWxpd2ph?=
 =?utf-8?B?aFo1MktrNUF2Z2s0dkFQUmlybFFzMUZBU0F0ZUpJTWMrdnVSYW5GRmswMC9s?=
 =?utf-8?B?c1g3N2M5WWFmUTd0RURUYmRnVG80VkRPTTZySmE5eExEYXFUQ0I0MElua1RS?=
 =?utf-8?B?b092Wnk3TTYxUkxjTVkzWWowTnl0a0JsN2EySlBYelBENlVVUVhoM240ekNH?=
 =?utf-8?B?bU5Ua0FUMjlIQ202M0syMzc5ejRyUnQ3aTU0NlVBMUtKa1NzWUgrbWpRY3hP?=
 =?utf-8?B?ejVmdk13UjhtVGZ3U1ZSZWpHc1RLUDBHakgzY2w0OU5CWXd2emZvaGh5YjE4?=
 =?utf-8?B?OGNmdTNJbG1RYzBTMU11bkhMLzk3RGtRakpiV2pWRllIeTM0WHhNYjVnNGJh?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74ED704DA504324B89CA9E4F206E4F3E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xh+TZYw9VFSKgOakbY1qblXqnCtZXqGfxI+RUrs/O286Bk5E3+PbIqkzu9h6NSH2VZF8bkc5Zx+Mmu+kFL8ol4CyE1cCTN85WAa8k2iBt4sOuKIAI9PKWC9ZS25hrn/wTEjFIAqH9WK6ti6tgIIIxYj8mA7+8ndsliP8RI0DlQ1YZMlfj1HpyTlicZts3HHUelT3fcdpFZkl5TPtlfqBGakf96/aB2/9P/JLw3GG6/zWXcJJ9z9+3AGAksYD+20EB0TezaM7Hwuwx1HW8XQ1B9oqzuygrJrz6F7qkAKhdvxSSvWlMxqpqoAU8OSURp2cxtsp1ESVlr5Thj6kIX/zpfPddxtDijxQLMEvmo4/aUFjWC5htTjoHC9KYMY97ZZUMxy/qiZx8mMIxI6vHh5+0ZfdkIftLxmf/F9+m1cHtYLytfQLoAtdgzIYRqz1zIoHydom+HJPs9t4MF7DAk9lzgOQKp6nzFXXnVGyxVf4exzwf1JJXi8462vg4T9a6e06F+Cgs+rGxUkWW4Bvx2lOoDHnCqEYnb0eiKt7zfpKmD0n4hA7pW/87FZOVl0RuyEHXLhjSEHU3EtWPKp0MO8MrPGBIYT0qU/gNdrV1ebPHLbvu0Jg/9TyXPSZYh6wx1Zb/zBq7cNSiC9mMWSq4tgnrRhQQRVSgBi/sOCCdaaA3MbI60mD5WIMJ8otLtUymaRt3S+pbEEho+lPlJHBNQkz+pHwIVrt4soQR2YQ/uNK8ChAVpxWrVtsQ3Kv+t5EazGs1m9vlDaWysvHi3M0eZvmofoem010Wo4evQy9iDQo0oJExeLJ+s6VL2x+IQAHN26J
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64aa6e1f-ec1a-4ee0-c29d-08dbe8584517
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 17:03:21.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeJPq/4PUuFQLgFgP1pq3hcSFNEb1EfpTtNM1UVJ2P90Gh5MjxIcYjbWVxo1+Uz756TjuajgvfRLATrU/TKqCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=927 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180130
X-Proofpoint-GUID: oxhTld1OMfy3e_p2SZ3ulfp1S7Dngge6
X-Proofpoint-ORIG-GUID: oxhTld1OMfy3e_p2SZ3ulfp1S7Dngge6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE5vdiAxOCwgMjAyMywgYXQgMTE6NDnigK9BTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIDIwMjMtMTEtMTggYXQg
MTY6NDEgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4+IE9uIE5vdiAxOCwg
MjAyMywgYXQgMTo0MuKAr0FNLCBDZWRyaWMgQmxhbmNoZXINCj4+PiA8Y2VkcmljLmJsYW5jaGVy
QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gRnJpLCAxNyBOb3YgMjAyMyBhdCAwODo0
MiwgQ2VkcmljIEJsYW5jaGVyDQo+Pj4gPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3Rl
Og0KPj4+PiANCj4+Pj4gSG93IG93bnMgYnVnemlsbGEubGludXgtbmZzLm9yZz8NCj4+PiANCj4+
PiBBcG9sb2dpZXMgZm9yIHRoZSB0eXBlLCBpdCBzaG91bGQgYmUgIndobyIsIG5vdCAiaG93Ii4N
Cj4+PiANCj4+PiBCdXQgdGhlIHByb2JsZW0gcmVtYWlucywgSSBzdGlsbCBkaWQgbm90IGdldCBh
biBhY2NvdW50IGNyZWF0aW9uDQo+Pj4gdG9rZW4NCj4+PiB2aWEgZW1haWwgZm9yICpBTlkqIG9m
IG15IGVtYWlsIGFkZHJlc3Nlcy4gSXQgYXBwZWFycyBhY2NvdW50DQo+Pj4gY3JlYXRpb24NCj4+
PiBpcyBicm9rZW4uDQo+PiANCj4+IFRyb25kIG93bnMgaXQuIEJ1dCBoZSdzIGFscmVhZHkgc2hv
d2VkIG1lIHRoZSBTTVRQIGxvZyBmcm9tDQo+PiBTdW5kYXkgbmlnaHQ6IGEgdG9rZW4gd2FzIHNl
bnQgb3V0LiBIYXZlIHlvdSBjaGVja2VkIHlvdXINCj4+IHNwYW0gZm9sZGVycz8NCj4gDQo+IEkn
bSBjbG9zaW5nIGl0IGRvd24uIEl0IGhhcyBiZWVuIHJ1biBhbmQgcGFpZCBmb3IgYnkgbWUsIGJ1
dCBJIGRvbid0DQo+IGhhdmUgdGltZSBvciByZXNvdXJjZXMgdG8ga2VlcCBkb2luZyBzby4NCg0K
VW5kZXJzdG9vZCBhYm91dCBsYWNrIG9mIHJlc291cmNlcywgYnV0IGlzIHRoZXJlIG5vLW9uZSB3
aG8gY2FuDQp0YWtlIG92ZXIgZm9yIHlvdSwgYXQgbGVhc3QgaW4gdGhlIHNob3J0IHRlcm0/IFlh
bmtpbmcgaXQgb3V0DQp3aXRob3V0IHdhcm5pbmcgaXMgbm90IGNvb2wuDQoNCkRvZXMgdGhpcyBh
bm5vdW5jZW1lbnQgaW5jbHVkZSBnaXQubGludXgtbmZzLm9yZyA8aHR0cDovL2dpdC5saW51eC1u
ZnMub3JnLz4gYW5kDQp3aWtpLmxpbnV4LW5mcy5vcmcgPGh0dHA6Ly93aWtpLmxpbnV4LW5mcy5v
cmcvPiBhcyB3ZWxsPw0KDQpBcyB0aGlzIHNpdGUgaXMgYSBsb25nLXRpbWUgY29tbXVuaXR5LXVz
ZWQgcmVzb3VyY2UsIGl0IHdvdWxkDQpiZSBmYWlyIGlmIHdlIGNvdWxkIGNvbWUgdXAgd2l0aCBh
IHRyYW5zaXRpb24gcGxhbiBpZiBpdCB0cnVseQ0KbmVlZHMgdG8gZ28gYXdheS4NCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=
