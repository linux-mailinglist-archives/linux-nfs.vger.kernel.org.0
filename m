Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFB7F0871
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKSTZH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 14:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSTZG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 14:25:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2DF9
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 11:25:03 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGjVnk025705;
        Sun, 19 Nov 2023 19:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kwxPQN9JYQqg+L9n+PDuu8BvWxuC2RI1zegl8sb7NWo=;
 b=cSavrjwQdUD+FGE+bTIRNmjOGu3jJwHGGPn2PN7U8QgOxZGmfV1eVmcyB+FCEuG300PZ
 UXke6RWqj4TmXaoVbFYeC25RGV/ssqsCSF8qDXgQG/zzYyLaGcR3ggHFodJWzMUwo83v
 wKWkuW1IjBXIDOT+SWSz+CU1e+7V4pJB3RQGHmtqSZIrukJL1bw5KzwplE9mRqyEg9h0
 7MNOnNPMjHQX0kdnSsEOsZdRBxb5rM7GkL2B+p/5UCb9llw83EFU146bW8nhVjq1n9kR
 5toPCR24sFSLgjggW3E62+2fVlKYtT1sOon7Dwfjh2FGgtv/PTPu0oPiRLPdy8NZpKOo zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentv9ds1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 19:24:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJHJcMV040646;
        Sun, 19 Nov 2023 19:24:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq49hhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 19:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMTdrDCAdoQccH7hzRY1JYNyAHtya+ddPkAnBYlPAJZquA3jGTtuJerBPV6wYJl4N6Dwz8MZAlRUCOilEtAZNVRiX8h2zvcPe/noDAoAj90B8QbdNZ+AcZLjGo8LdzFaKc7Q3jL54eYUs9BrnZBQ0hSIUR1JvdVHeXymWcQMzdi9I2aLGoMtm8CWm9VES48GmN6QvV24YJ0z9uzGsc5pryPsln04zW5OvCa4IX3l212wOc01JkBRtrpxxVO4lufFHz0u8LTT5qVaoKkAKe3Q8QZpMq0Kt+VBjolr+M8ZmbJipaZpjhlPBzpseNdoiwfmBRBTVwOX/Xw4ow2pVnbp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwxPQN9JYQqg+L9n+PDuu8BvWxuC2RI1zegl8sb7NWo=;
 b=CLG9GHCvPdt5V4VE4VdT5AHym0nTNsfpVGaSBtYzxhNsEBtKE+xFZ5vd6uV6RcQZCAjLgGe1fgl9XCc8DLuWvOP+4PVp05xSSYi7ic6r8XkQp0MhYxRJLrsnv75CXZ+59ivQWSWlzJAirweElEshXvPDsY3OtnWOQtG7kuA0bAqxpWWEhoV+oDMmq8VCj8xzYCi25tYdfGZGFP2MmQpmFSUtjCJyLyx0Nnm9nWRdSWoo7nB0cDXa7PuHus0qxuIZ2vQ0rXoLugC9SbvCQMmO2VUCRLYZbbIXBXluEDFyJ0JF4q1AO28lkwqZQ7MAkBUstH7jHovMCHeYXPKBXuq3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwxPQN9JYQqg+L9n+PDuu8BvWxuC2RI1zegl8sb7NWo=;
 b=x+RdpnKl2eQOr5fiZs2K2HPsNCTl3xk+K5/QR2YecgjgRbLN/OZr5eZIGVsV4NMNGla3oqrIx4ck2/752a9sC1rPoy60y7E+FlAurMUFbCy33zHZ5bjskG8VoKaNJbIEe3OZfo7uzD6X74xEhnQbaRgrycA+D3SGHD+rL4LTJ2o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 19:24:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 19:24:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Steve Dickson <steved@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qAgAA+NgCAAS6GgIAATSeA
Date:   Sun, 19 Nov 2023 19:24:55 +0000
Message-ID: <8DEB4FD2-BF31-48B2-8F40-7BEA22AE26EA@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <CAFX2JfmrWONe9UO2_qpbgdJRWuG+BXa3-ivcr4wTuWwBg4Oe+w@mail.gmail.com>
In-Reply-To: <CAFX2JfmrWONe9UO2_qpbgdJRWuG+BXa3-ivcr4wTuWwBg4Oe+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5544:EE_
x-ms-office365-filtering-correlation-id: 7c394ea9-7f7c-49d6-6e2a-08dbe9353631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KipRPa8eQQ9pnettsKpP/FEBL+nbxbOjOD8VcJXLjClB1YJWVTcX3GYp8Q8xlIMCZJqg/leJ4rszDhvcU0PLLUof6NYJBuGyVH+L30cBkC1A2IP+3eo7jEM1Fy649Reei1OhZm7XAmnBUCxUOapI8HLyrpaTLJ5Hod8o7+fkd9hDvUxfprz/nU7eIQjaq8uIIoQ1mNt/AMMLaT7DVUi0NaR0pzjiGZDfkEkOkNpsR1mJZrGKdJg7WpURqa9v3eW8Aucr6GoVr+0vNYNIkz4hdz33V82/cvYTZteozsOFRfO1IUCuThqEIMKL2qTBKl+S8pnyeFV3IXJE2xQ5aYUgyYsSXsXYSGV5WAdacGKhq4bro1TGCUoERurVIkBoDzi1S5ymSbsOd2YpERkNvyiKxyu42HFF62s+pPvAQfwqSGDID9qF8S77pHI4xXJBg4i2J4LiWmkHTf/R4JC5eVaE4tPxLYQAqD7mZ9KAOkL08KwEiXs1iMJ0gCW7rqlGld8nkc+v8n9ZajOqwJLxvtN3Ef9ibN5e7+9oh5IO/4AcO3DUfe4BqxK/MUYQmQHSNdbrQUMDzycZ9Eyd7o6oqpP8Idk9m3GUDS0v68PGMzH5QOB+ts4tnsHiCOfX9M/sHB9FOJeOoqzWyYMFOaR2GEf4qqWYTG00xMzXEoNoJQqQQDnVCodSA1IYah5jBzJ5n46oy393mDfmLGSRQtvldLRjrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(2616005)(33656002)(66446008)(316002)(6916009)(64756008)(54906003)(122000001)(41300700001)(36756003)(6506007)(53546011)(6512007)(38070700009)(66476007)(26005)(83380400001)(4001150100001)(2906002)(71200400001)(15650500001)(5660300002)(86362001)(76116006)(66946007)(66556008)(91956017)(478600001)(38100700002)(6486002)(8676002)(4326008)(8936002)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnBIRmdIcVlyM2ZYdzF0cEZldjU3TGZHZzBvZXFmRHRNQlhLK1ZYUERKbGxZ?=
 =?utf-8?B?UFZMYUJKdk1WQ1VPUW9DdjkwZW9OTmhPcytDZ0orVm1xaGlKcDdLNVVMYm4v?=
 =?utf-8?B?UHY3NEF4YnBmOU90dXNhZHRlbkFPRjB2enFzR3NzZmFsdnJzNEgvMGgxOTRr?=
 =?utf-8?B?TXFYeXJTcWNkVDQwU2Y2NFpqbHJ4L2ErMnRGNko2Z0FvK2M5STBqaXd6dUJZ?=
 =?utf-8?B?UFRsYVZEMmJVazg5SHZJYml3QUxraUNNZm1SSjRoNDl4OE9XbjlFZWVaZldM?=
 =?utf-8?B?VTZYMjBDUTBvNFgvUUxzd0FnRml0Kzg4MGx4UEpEeW5yQ0kzSGhxbXBUcG5X?=
 =?utf-8?B?UXpIbHF4bHNJU010VTIvTmpERXNsS2QrQVhpMHpRU2Y3Y2RRY2JJLzV5N0hm?=
 =?utf-8?B?RVE2NnZVK3I3Q3VpaDdtczdJcjVkUzRRN1ZOcGttSmVTYzcvczZkVzlHOHpV?=
 =?utf-8?B?ejRORjVLS1ZXNDBiYkN6cnc0L3JvQnNSM0hVRkIyMUpJeVBremhWbHk4dWZL?=
 =?utf-8?B?b0lPeExXVXEzRytieW8ybC9wWEpxdXpCb0c3Y1dENkVHbElUWkZtSGhkcXNj?=
 =?utf-8?B?RUNvaU1IZ1M0TjRiMnRIK3R2NUVwampjb3hYUmY4T3lyNXg3TEdYZy9LdkQ0?=
 =?utf-8?B?cFVBQ0ZQT29MYUpVRk5lVnAycjlobkM5SjlOaVNvOEdsL1Q2VE1pTDVvbGk2?=
 =?utf-8?B?WTNyN0Vnc3lIUHJ1QnhRbEM4Q2JPc09BYmp5Q0JpV2tzN21BbnFoVW45TDZI?=
 =?utf-8?B?dzJhL3JKTFRucUlUeHdXL0NBaDd4WXBFMjlHWnVoaXR1NTlWaEJTZkVnS0k0?=
 =?utf-8?B?L3pEeTZQVXhFZ1RqUGpSQkl1S0FtWC9nMnhJWk00V05MU1pSVWM5QlFnd1Jk?=
 =?utf-8?B?Yk9ZVzhEd0pLKytudFF3WDFoMXlNYW85OFA2aW95WHhrQlY3dWRvU3IwaXVr?=
 =?utf-8?B?c1haUkkvb0E2cXNhc1VGdmhEV1M2RWxyeXh6ZEJ2SWIyNnlsZEhwSGFCNVAv?=
 =?utf-8?B?OGoxT3FOWDVQcDBkbThwTGRROHM0dEErdGVYZi95MGpCN2lmUlBFOVA5MEtK?=
 =?utf-8?B?d2xWZWI0bWVXQUhqRGF4VHFzMHhxSENjSTBnVHhKWlhSdklBaVRSdWs3anRr?=
 =?utf-8?B?cHVhSzI3alJCV1dmdko3OWVWcGdvUWNlL3MvVHpWczUzNTJjNWF0RHJHaFll?=
 =?utf-8?B?RFYvdEkxc3lEdU93eUI1WHZXMzhpZlFPek15aTZyYUIrdVpxV1pNTG5vUy9p?=
 =?utf-8?B?NjlzZE1ueE9BV2RJdmFSRG1LWWN1NFRLRVh1bUh4QU5tK1BUVEhYYVNPZHRT?=
 =?utf-8?B?SlEzQ3V1OC8zYnRhcis5RU5FZHVPQmttY01lOSs4NXZpT2JBQ1EvdElEd0Jh?=
 =?utf-8?B?RXRjdEprYmZCQ2NuK2xLZENWSWplOVlOUUdSc1llMnRuV3hvcnIwbHljMHFN?=
 =?utf-8?B?eGhqUnFXT0diMnFxTVNVWWVScUJYRjcrSUZlaTV1T0VpWHNtcmlzYmdpNXRx?=
 =?utf-8?B?RUp3K09CUkJCWEw4SURrNDNBS0ZMbG13ZmQ2ejVVcHBQUDhEcmpQditxbjVC?=
 =?utf-8?B?SmJmajNyUGJGVnhIaHVNKzBhMUxzaC82S0FYVTArb2I2cGk0M29ZWWxmK0Js?=
 =?utf-8?B?a2RTMzdQNzFaMERZTzBxYmtYTDlCQ2wxd21NUVNrekpjZTRkZUdLaDd3N2o2?=
 =?utf-8?B?TGUyem13YnZBN0NSOStTaGoxckl4ZU9HdkxuZ1FYQWZMZUJvWUJDazJ1K1li?=
 =?utf-8?B?aWh3K0RZWXc4MDBIOE9hVldiYjFGWmcxR0o3QlpQN0VURzgvYm1UanEvUy9i?=
 =?utf-8?B?cGhtOU54K3gzdjBDSVZMYzlSaDhFN2VrK1hXRVJUajEwS3FTZExka3BmdjlM?=
 =?utf-8?B?RitiR0tLTDdUK1I0UGxIUXJ2Q3hmRFlnV2JQQ1BGNWxmbEVLN3Yzenh5b0Jm?=
 =?utf-8?B?L0E2MzVkSXpkZEpudzdwM0hDSzR4cHdLY3gvekVteS93U3B0dTNGdmFoVzRp?=
 =?utf-8?B?a0h0ckljNDBQZXRZSFZNNzlYTEo2RnRoYU5XUndaQ2VPU1FXc1NNOUF1dFR1?=
 =?utf-8?B?Tm9jd2ZHb2RVVjdMaTBkYTdTQzFGZzdwTHltbS90d200TkRJb1FVOUtULzJU?=
 =?utf-8?B?Z3FybUloVUxqclpVcVprVG1qUjg5MnhFMjZEN3RZbDJSbE9yRk5LbkFUcjY0?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FFE90C22C62AE48A51D37FC32A21C07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FrQBSZhhyIdSIFyeZsW8SXINq6/n5g5TqRhU7mp3AeNUnwsfcgTC2OwV8SyT78IQB6LjwOsdOqlgCONQiqLr9ec2EuFojOCFPWq4gG1tiInDC6NueYr/xvAvywC8XzqIp1vQWq8oiqPsVBObIqXJMlqqmEJ0o2SG+Mn2LQTWX77CVKySVmrNEEldttr3llRt2ojteDBZp6JFcG1IPUiWM86jE9+trV/d5M43uM+o1ivMGR+sSn29di0Ao+mPru8OHzDsuYTM4M4NTsfmZuFp9iDW/MBBrc+XBDOoiQmn23b0KQKtqKqIHn3YrehMiuQaB2BIZVpRLMl5n/3fY6Acc9/Gyu1DjRwjRDbKjnlqHrREGeP3yqMOVpQ+DAKKAxmneZNMfVFBjIvbHKPHLdaWo8aiSJg0mwP/dl7dyTpRrO4/8STZ0auRzBPhff70TIqQvj4ekYyNEfjMUVgc8sSzOQA89IvUXvJwVHWX1dYiHvXnaAjgTsT/J945K5BmIG394AmlSNvyXMC+bzZFuWyBj/qh8kjl2v1wScn9Dkj0Pe5fGP+ktClC1Q0axghIj8lKXGk0/26Hil8aPWQ9ihFaxcqBlWXsvRsLvW0BX5Nf6Wkt+9ZgXCTU15FZcUNiPPr2AIREOBBRafviY6CiBiRYP3pbokzkXME5h1uwMn9+WLW4osJ17IIJv04kwPK69Fh8AH2JliEuPcahkEi9aFNS3tTURT2iPXRS+XBzWTGygNEBkiYDOQAGRLBhCpO/Eeee8Z78qDfbRerZHcmQGAkbARq3mJBXggk3HnRnwX02ZQO3PQxovJ/6gxeynuG/d20M62wJRFazW9Dgs874pgRLtnDfmn1Az/qcKgLZnrCZgEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c394ea9-7f7c-49d6-6e2a-08dbe9353631
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2023 19:24:55.4294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDBan+DQAn8nNyev7Cak8iqJBfMWhpsb9uBNMT94wDWwu2nitvYafxj+9RycQ1w2PTwsl0FrF9B++39utgQ8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190148
X-Proofpoint-ORIG-GUID: C6Jbxm_FN3mSKc5gp-IiTT_qkTii_XrS
X-Proofpoint-GUID: C6Jbxm_FN3mSKc5gp-IiTT_qkTii_XrS
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE5vdiAxOSwgMjAyMywgYXQgOTo0OOKAr0FNLCBBbm5hIFNjaHVtYWtlciA8c2NodW1h
a2VyLmFubmFAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgTm92IDE4LCAyMDIzIGF0
IDM6NDbigK9QTSBTdGV2ZSBEaWNrc29uIDxzdGV2ZWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IE9uIDExLzE4LzIzIDEyOjAzIFBNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4gDQo+
Pj4+IE9uIE5vdiAxOCwgMjAyMywgYXQgMTE6NDnigK9BTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBTYXQsIDIwMjMtMTEt
MTggYXQgMTY6NDEgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4+
IE9uIE5vdiAxOCwgMjAyMywgYXQgMTo0MuKAr0FNLCBDZWRyaWMgQmxhbmNoZXINCj4+Pj4+PiA8
Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gRnJp
LCAxNyBOb3YgMjAyMyBhdCAwODo0MiwgQ2VkcmljIEJsYW5jaGVyDQo+Pj4+Pj4gPGNlZHJpYy5i
bGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93IG93bnMgYnVn
emlsbGEubGludXgtbmZzLm9yZz8NCj4+Pj4+PiANCj4+Pj4+PiBBcG9sb2dpZXMgZm9yIHRoZSB0
eXBlLCBpdCBzaG91bGQgYmUgIndobyIsIG5vdCAiaG93Ii4NCj4+Pj4+PiANCj4+Pj4+PiBCdXQg
dGhlIHByb2JsZW0gcmVtYWlucywgSSBzdGlsbCBkaWQgbm90IGdldCBhbiBhY2NvdW50IGNyZWF0
aW9uDQo+Pj4+Pj4gdG9rZW4NCj4+Pj4+PiB2aWEgZW1haWwgZm9yICpBTlkqIG9mIG15IGVtYWls
IGFkZHJlc3Nlcy4gSXQgYXBwZWFycyBhY2NvdW50DQo+Pj4+Pj4gY3JlYXRpb24NCj4+Pj4+PiBp
cyBicm9rZW4uDQo+Pj4+PiANCj4+Pj4+IFRyb25kIG93bnMgaXQuIEJ1dCBoZSdzIGFscmVhZHkg
c2hvd2VkIG1lIHRoZSBTTVRQIGxvZyBmcm9tDQo+Pj4+PiBTdW5kYXkgbmlnaHQ6IGEgdG9rZW4g
d2FzIHNlbnQgb3V0LiBIYXZlIHlvdSBjaGVja2VkIHlvdXINCj4+Pj4+IHNwYW0gZm9sZGVycz8N
Cj4+Pj4gDQo+Pj4+IEknbSBjbG9zaW5nIGl0IGRvd24uIEl0IGhhcyBiZWVuIHJ1biBhbmQgcGFp
ZCBmb3IgYnkgbWUsIGJ1dCBJIGRvbid0DQo+Pj4+IGhhdmUgdGltZSBvciByZXNvdXJjZXMgdG8g
a2VlcCBkb2luZyBzby4NCj4+PiANCj4+PiBVbmRlcnN0b29kIGFib3V0IGxhY2sgb2YgcmVzb3Vy
Y2VzLCBidXQgaXMgdGhlcmUgbm8tb25lIHdobyBjYW4NCj4+PiB0YWtlIG92ZXIgZm9yIHlvdSwg
YXQgbGVhc3QgaW4gdGhlIHNob3J0IHRlcm0/IFlhbmtpbmcgaXQgb3V0DQo+Pj4gd2l0aG91dCB3
YXJuaW5nIGlzIG5vdCBjb29sLg0KPj4+IA0KPj4+IERvZXMgdGhpcyBhbm5vdW5jZW1lbnQgaW5j
bHVkZSBnaXQubGludXgtbmZzLm9yZyA8aHR0cDovL2dpdC5saW51eC1uZnMub3JnLz4gYW5kDQo+
Pj4gd2lraS5saW51eC1uZnMub3JnIDxodHRwOi8vd2lraS5saW51eC1uZnMub3JnLz4gYXMgd2Vs
bD8NCj4+PiANCj4+PiBBcyB0aGlzIHNpdGUgaXMgYSBsb25nLXRpbWUgY29tbXVuaXR5LXVzZWQg
cmVzb3VyY2UsIGl0IHdvdWxkDQo+Pj4gYmUgZmFpciBpZiB3ZSBjb3VsZCBjb21lIHVwIHdpdGgg
YSB0cmFuc2l0aW9uIHBsYW4gaWYgaXQgdHJ1bHkNCj4+PiBuZWVkcyB0byBnbyBhd2F5Lg0KPj4g
DQo+PiBJZiB5b3UgbmVlZCByZXNvdXJjZXMgYW5kIHRpbWUuLi4gUGxlYXNlIHJlYWNoIG91dC4u
Lg0KPj4gDQo+PiBUaGlzIGlzIGEgY29tbXVuaXR5Li4uIEknbSBzdXJlIHdlIGNhbiBmaWd1cmUg
c29tZXRoaW5nIG91dC4NCj4+IEJ1dCBwbGVhc2UgdHVybiBpdCBiYWNrIG9uLg0KPiANCj4gSSB3
b25kZXIgaWYgc29tZXRoaW5nIGxpa2UgYSBnaXRsYWIgLyBnaXRlYSBpbnN0YW5jZSB3b3VsZCBz
dWl0IG91cg0KPiBuZWVkcz8gVGhhdCB3b3VsZCBnZXQgdXMgYSBjb21iaW5lZCBnaXQgaG9zdGlu
Zywgd2lraSwgYW5kIGlzc3VlDQo+IHRyYWNrZXIgaW4gb25lIHdlYiBhcHBsaWNhdGlvbiB3aGlj
aCBtaWdodCBtYWtlIG92ZXJhbGwgbWFpbnRlbmFuY2UNCj4gZWFzaWVyIChvbmNlIHdlIGdldCB0
aHJvdWdoIHdoYXQgSSBhc3N1bWUgd291bGQgYmUgYSB0ZWRpb3VzIGluaXRpYWwNCj4gbWlncmF0
aW9uKS4NCg0KSSdkIGJlIGNvbWZvcnRhYmxlIHdpdGggdGhhdCB0eXBlIG9mIHNlcnZpY2UgdG8g
cmVwbGFjZSBsaW51eC1uZnMub3JnIDxodHRwOi8vbGludXgtbmZzLm9yZy8+Ow0KdGhleSBjb3Vs
ZCBhbHNvIHRha2UgY2FyZSBvZiB1c2VyIG1hbmFnZW1lbnQsIGFjY2VzcyBjb250cm9sLCBhbmQN
CnNlY3VyaXR5IGlzc3Vlcy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
