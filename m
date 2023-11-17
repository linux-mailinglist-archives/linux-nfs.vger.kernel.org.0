Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3487EF7A1
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjKQS6q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 13:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKQS6p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 13:58:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6A90
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 10:58:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIPlb9017519;
        Fri, 17 Nov 2023 18:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4VGR+q07XIMSRYaJ4rrNRN6ZJZUceiRo2a4/EwL4vzc=;
 b=Xr6sxKcT0z29zB00oGDY/+fyn/TQhbbJYxVN1iAYvzKxz6OSxl6myTXTnwYGEBtDa/Y7
 bVNrl1avB6DWiozFTLoah0neZ28fbf3aRUA9S/o/jUe7MeJiQzNuUMc/fpR05FbrFNbt
 Hdv6TCfjF/a9ydJno/BY+94G80oqz84OzFY9jSJ0TOVrIC+LbpEk85BoumPcEIfCVCih
 AHhgDpPmZCI8+i2c9096lv0ZNUomdIAA26D0xVtJ08fn9xYyd/Pl7qdV90v96QmN5CEE
 W7zEGjChLPJKoSUmaMC3+1CljthPIDKU3YfOlL7NygNxvnPWoznQ/XFhzwKnj9iBKHM3 zQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stx2jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 18:58:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIlCZ6028291;
        Fri, 17 Nov 2023 18:58:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq4xkd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 18:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCoTzvm6oTjKAVxvAIQgh/e675XPENiXJ+/1d9fB00laoCn+WhhLO5jqve9HGPeEGuMAv72T8/ysO/C5V+ymnZkzUyx63/fN/SLUwkOdZpxzzaUKNgixQsv74lH6/2EfgMGMIXM/Z8jNlixedEJSNS14Cz8XzR9vEVqoDwlRtfQxHp0etG7eMHOS/iKsdZYJniGhGMS8mXOKVNKtqvR6V8aKQLveSRmmVYOLehz5hVHJsvspyqJ0rb+EI6kNucdYaJ3VuJ10WbfCVfavB2sG1tqirgIqcE5SVRc5x4SCKItRaoWdTjuQzc7lylpkjlk4rCzJpwZERXHTpzqhHnPUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VGR+q07XIMSRYaJ4rrNRN6ZJZUceiRo2a4/EwL4vzc=;
 b=D0keXAPDMLsHL3BvqB3BNZq9PMQebAJEtJABEyPim6JBYf8TizpmRiZBaA/1qC9FpBMQSYmeIhK17gxGk6uh72rFXMEzz38T2LqHAIh3JkbBy7QWFAUQDD32MGpgXwsEt6BN9JbIK/a7nAOfcDWwKAAxe67Xlb54pVz4bnpmDvzqzRfsWd7oFGWHji6ErpU8L4A29H9qi1K46LQfI6CuK8dgtqfPzfpTilJWKxrurObQWmntir05f2RYhKeVHvWzpJ+NUJO7iq70Y1Tgo2mgo9BwL8S2Mw4NeIxhkhAV02R28dJELT7wzn9cUDhTIk+Ihz72dNAb9RLgo9g0FO77+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VGR+q07XIMSRYaJ4rrNRN6ZJZUceiRo2a4/EwL4vzc=;
 b=V73ZZQyZAL/W+cjGL0vpdcCCfEEIlo1+kI9ywcMA/qHFOkEQjLSoqQe/Cp1pzXN5b9lT2LC48MM2kDQoyOKo3VW9HeSPPUq5qlknWVIPAlJ5MKHv6aY5V2rVGJmJAo2+lTbW7ZhVYwc2iytWiEzi61gjyd5AsF3QqUwsbwo9gVo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5923.namprd10.prod.outlook.com (2603:10b6:208:3d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 18:58:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 18:58:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
Thread-Topic: [PATCH v2 1/3] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
Thread-Index: AQHaFAAKdT1AROPXNUmWC1qSMEkmT7B+pNyA//+vJYCAAJQLgA==
Date:   Fri, 17 Nov 2023 18:58:28 +0000
Message-ID: <89371272-28FB-4549-AEBB-56CA6641F1C3@oracle.com>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
 <169963371324.5404.3057239228897633466.stgit@bazille.1015granger.net>
 <ec54d81630f78c764c930a50b4ba75b26e4b8ff0.camel@kernel.org>
 <ZVeB5kfH6YAzgwd1@tissot.1015granger.net>
In-Reply-To: <ZVeB5kfH6YAzgwd1@tissot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB5923:EE_
x-ms-office365-filtering-correlation-id: 5d81a1ed-2bd3-4969-adc8-08dbe79f2f35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iq6FQq6pM3Th1yd6AcoowVYjviOaxVOz/3rdG/G3AHete1GQfg5vfDatmSlJASMaJYx3ZQ/f0gGIvRiv7NvBkAeUU1Ek+SeQ50njHBpHLmtEP7dLa8ozhwSiw+TCPTBlwJDIbVaVVZfRdqlKe2kUKDTX27v9N9LhcmtvB9JCMdTjELORJgMxIYzrMQB80/pHar6YtfI//+6AzHdrh1H/VTAfU8EyBxtaUXTH7AgxdVsd4qmBqoUzTdL5qJ+n4Ouf5Y6nW0pY7f2i0k03SA11qOb5fCLk1tVWGJBkX6o+j9uMFcSoMteFGTx5RcjxaW7twFrFiWf0wBFKSLOkDwPMixF6RTUOptilX51DRZrkd607Km3Mz8NcYpdGZi+M99Pu0W2PrITM34oyf8eZqHgZB/lN5arC9I3c//2nWRyIFZtmdaTTiMwaAJ17kb3bbYNuKR+S5DsGKbIlTVgvSKjv/VhfZ7hdZIS2qDxXYJB7cWeBpQV0rBw4ODieWbolLm3CCDLkHhMoJkgm0hSHlpK/XbGtudbLOYrExio+TUhshjnf3IDcpfEekRz+20DtjAdyrSxZ2CC89BN7fG8NNcY4JqFi4ADKMn8Nb+UjnOeS65Q/w75DFc7DVuZbR8yNVIrW0ran3nHwjwi3QeOs59aatQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(6512007)(6486002)(6916009)(478600001)(38100700002)(316002)(83380400001)(4001150100001)(122000001)(38070700009)(41300700001)(8936002)(8676002)(5660300002)(4326008)(71200400001)(6506007)(26005)(86362001)(66556008)(66946007)(66476007)(91956017)(2906002)(2616005)(53546011)(76116006)(54906003)(64756008)(33656002)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnVvSWJUaDhqN1Jza09mR0prRUpqUGpERFhma1drN1VaT0cxMUtvajE0SFVJ?=
 =?utf-8?B?NkhGZlhJSzAzOWRlVXAzdk12RW9kc0owTnV2NDd4RHQ4R0k5bWQ1clNRVzI3?=
 =?utf-8?B?UW96alh4WGNzSVN3NFFYdzJ5OXl5NjNTeE1Sak9PV1c2Y0w1ZzhMQmUvTVBV?=
 =?utf-8?B?emlBUWpHcDhYbXNCRTgxUFlpY0NsWmQ4dVc3dzhTZ1FhdzlQZHRWYzRsR2hx?=
 =?utf-8?B?Q0V4NjBYbm9CdFdFcXBJdXFpclVHS1lMekgyTGhSc1RJcnV5aGRqNWl5U2dD?=
 =?utf-8?B?Y3c0RXVLa24rdi9hRXdOMVhxRUFYbVF1L1dwekhQTTN6Z0pzWWpsUDNtUC9V?=
 =?utf-8?B?YzBQZloxOTJRL0VPQVJuNGpTZmd4TkZNdFZPOHRyelJZT3dHTThqN0lTTzI1?=
 =?utf-8?B?U0M1bDFZSGpIYVVGd1dFYnAybm4rT0xRYnUvWVQ3dmtnWGc2TTY4aTRMajRr?=
 =?utf-8?B?QmZyMUhpMlI0Ujd6WHZsVmdZM3VEZDh5cVJBT3ZKUDhZL1ZvUjRpMGFvaU9H?=
 =?utf-8?B?NnBseEtST3VxU3kxWU0vMzRUREthMlVuL3ZaYzk4bFZRZ0V3OU1zdE0zY2dG?=
 =?utf-8?B?dWVkcGg4ejd0QWtUSXJGT2VJWHArek4wcnMrM1RUc0pFM0lLOHZ3Q05rODZQ?=
 =?utf-8?B?aGdiRUdaQWcyem4xMWRtaGNsNU81ZXRoUmdlRktMblUwSzRnWFd5SG1laldM?=
 =?utf-8?B?Tk5tdXpIdlQyUVMxdHd3NnNpVWp5NkhYa2tDQjRVeTFVWnJkc0I0NjcwNVlr?=
 =?utf-8?B?N2R0RDdCcmdKcmpVRUpaQXBOYWJJTEZxRExsTVJNNHpQMWFUMlp2U0xjamlr?=
 =?utf-8?B?bHZVMmRqZGRwZzk4Y0Nxd2lqU1Y5NXkyQVZpaFdQMzNqbXMxWEJ4NDArZUtH?=
 =?utf-8?B?Uk1IMUVFb3cxeHZRdG9TWmVXSzhidE1VWkJ4cFUxWER3Um9BcHYvUVRteTVo?=
 =?utf-8?B?S3VzZDgxZjRIeFB1UUR0bVo2ZSs4Q0swakFYSXVSOEZWVXJGdmJvVjQ0Qis0?=
 =?utf-8?B?SGFpUWVUamVHL1FHejRUOWpEVlRnK2xYK1RZaGpuOHBZc1BTbTBmclZWNnhl?=
 =?utf-8?B?SmhkbDZyNU5BNkRIZ0U5WS9waWcxbDRPaGx3YjA0TVRsRUFYN3hIOUNnZkZU?=
 =?utf-8?B?VXhEYzRrRDRQV1kyTzlJVVJaeWlsVWxnSlBDVzVBY01tRWt2MHI3WmRZTlU2?=
 =?utf-8?B?MjlIRXpvOGwwZUVqUkJydVZCd2YvY3p5ZnpFZGhkdWE2UWxocXp0VlA0MmhU?=
 =?utf-8?B?M0VhSWRtM3JYZDNNazlXNHEycEJXRlJnTld6N1lrKzU2RTNXK3BZc3hRR2Vm?=
 =?utf-8?B?bmhiTHZVNk5ES05RL1VQUHNlUzJhQnhiZjNnb1k5QWNsZmZadDVYbmptV0Iz?=
 =?utf-8?B?UklWOW5RK25XQWVLUndZQWFZUHNxUlZtK2kzb09GZ3dKWDBpR1NPY0UxWFJW?=
 =?utf-8?B?Q3BTeE1iWEsvdnd3Q05oU0Q4THplWWtycnVXUFhKREJhVHMzb2RZZXpld1Bj?=
 =?utf-8?B?czVneDNFZGIvQ1pjc0ZjaDdQeHRLU1VCY1RSS1JvdVJNYWRrV0tEcGlKVEFx?=
 =?utf-8?B?S09UZitOTFBrWnJaemxGbVRScUhLV3NDM1pocytZRm0zNml6RW5tckp4SGd4?=
 =?utf-8?B?V2owYnNkWGE1SlhLWWlMVFdPUlE1ejdPYnJwbTJNTVNxd0xubE85VlpWVi84?=
 =?utf-8?B?SUQvR2pHeWNlclpmMzFMd2xBQUswRGxYdG5OT2FnQksxVFBYL0VpSklYQm14?=
 =?utf-8?B?ZVNjekZNUmI4a0lmZlBOdWFYb3BaM0xUQWNkMHZsZWNsQ2pkQ1VsNHNVSktV?=
 =?utf-8?B?QUpISGh2WEJVK05BZVlCc1BPUkFnOUxldVFScUFZR3YyS1pJOTRIQllncGlp?=
 =?utf-8?B?elV1YzRrK1VWZDBvUFY0Wjg1enVNLzVPZHk0R2x6RUZGS3pOeDRsV0kzR01O?=
 =?utf-8?B?TkJibkhLS2dnUzQ3eitNd1ZmSk9ENjludFphaFpFYzBqaXJHaXZ5OVJBdnBT?=
 =?utf-8?B?SENGTFQwYkVkdXlhRVpPMGdPdUhKYlkvcVZtalJQZW5oUmxSSWdlVnNDdnp4?=
 =?utf-8?B?YzVqYmloTkMvTitLMVRRc0d3Q3dnZkxXc1dmcjM0ellMV2tvaGEyYXhiWHU3?=
 =?utf-8?B?bGhvTHRVTWNwMW0rVU8rOThZM2x5bS9oR2ZhOE54WnZrTUxZUU5qSHpoWUVl?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7587F6CDE95AB54E94FAA36F4CD54171@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kp9837VCTC3b4CxsiUd+cQ7zE10PZHl5L7hD4eAdnvnPtWOW0ynSwISprtkNdvjmRx0yO7IKmcq1TuI3i6W32jZhd/8T+XLfeFKEgfwAnFVbnANVah+6Mvx5vr8+9aU2fIhOrxXyvWAn2tWhCV1l2GkppvC8h4gLagWR3XBWeba4wo5VJljTKqtzAw3aqh7PDkUTUWIUzvx6L0mVv1kxwsKHSn0kgCvAGcFYObwRso15WBtP7vYioYm0sFNsnwrFlrwH0H1bvzLUd9jxbe5S88CLiA1UjNXBlp8gWc+GPDGMwmVPP4Ddqbg0XIbAuo1DZ0zCbOwB/qoL8d9i5JHtQlFrAtkFJR5kIEKU/0yMVb36/btqN0Iqs7QxbIRiS/Svo2ac8L307yrlzyosU0aZUBBlWAP4Sn6Vy3Q/SHkhcYFsLjUtwDpgHqZS0k4GsBJDoeTh1AZ+DkYuf+iVfdLDDDP//O2oXvrZ2rhOWV5YfIilRCaVXOETtXjtyqTuDJ1rASrDPLBv7rgvjRL/p/VfGaQ2jY7EwG/N52359L9okWsw1HmNqcBemqF7CyF4iANhNbkbaVVFVqjw8HbgQPneJv2ea/tHP7uxJtyWwHIQ1IOz9Sh6zxpLy8bz4R2xf425Ue4o/gMh22IEyz0J8d9OkXhhg82b2KZMI7xbrkT20TLoJ1b05ExLkJg6nnfXZegnj9dlyoDeFAPfexxPEzOgz+1OiQOHi7IT0pLvvScbCf+aDKGWIuI3qr4TBSqwL1Natiu33wrl5EUQgS5uqO0BKD9e4wMmOrUFy+hTdIHlSRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d81a1ed-2bd3-4969-adc8-08dbe79f2f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 18:58:28.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWnjA/JMFheEqNXZL+3AOsfGgs2ZPatvYWQQ7SDFOVZKDJDiQBnC0P1maJ0CK1exiGW146ExJ8WnF1RWMdeXuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170143
X-Proofpoint-GUID: AZr4uGyTf1nwP5Y-8nP9WDbzE4pFOnat
X-Proofpoint-ORIG-GUID: AZr4uGyTf1nwP5Y-8nP9WDbzE4pFOnat
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE3LCAyMDIzLCBhdCAxMDowOOKAr0FNLCBDaHVjayBMZXZlciA8Y2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE5vdiAxNywgMjAyMyBhdCAw
OTo1Nzo0OUFNIC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4+IE9uIEZyaSwgMjAyMy0xMS0x
MCBhdCAxMToyOCAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gRnJvbTogQ2h1Y2sgTGV2
ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+Pj4gDQo+Pj4gVGhlICJzdGF0cCArIDEiIHBv
aW50ZXIgdGhhdCBpcyBwYXNzZWQgdG8gbmZzZF9jYWNoZV91cGRhdGUoKSBpcw0KPj4+IHN1cHBv
c2VkIHRvIHBvaW50IHRvIHRoZSBzdGFydCBvZiB0aGUgZWdyZXNzIE5GUyBSZXBseSBoZWFkZXIu
IEluDQo+Pj4gZmFjdCwgaXQgZG9lcyBwb2ludCB0aGVyZSBmb3IgQVVUSF9TWVMgYW5kIFJQQ1NF
Q19HU1NfS1JCNSByZXF1ZXN0cy4NCj4+PiANCj4+PiBCdXQgYm90aCBrcmI1aSBhbmQga3JiNXAg
YWRkIGZpZWxkcyBiZXR3ZWVuIHRoZSBSUEMgaGVhZGVyJ3MNCj4+PiBhY2NlcHRfc3RhdCBmaWVs
ZCBhbmQgdGhlIHN0YXJ0IG9mIHRoZSBORlMgUmVwbHkgaGVhZGVyLiBJbiB0aG9zZQ0KPj4+IGNh
c2VzLCAic3RhdHAgKyAxIiBwb2ludHMgYXQgdGhlIGV4dHJhIGZpZWxkcyBpbnN0ZWFkIG9mIHRo
ZSBSZXBseS4NCj4+PiBUaGUgcmVzdWx0IGlzIHRoYXQgbmZzZF9jYWNoZV91cGRhdGUoKSBjYWNo
ZXMgd2hhdCBsb29rcyB0byB0aGUNCj4+PiBjbGllbnQgbGlrZSBnYXJiYWdlLg0KPj4+IA0KPj4+
IEEgY29ubmVjdGlvbiBicmVhayBjYW4gb2NjdXIgZm9yIGEgbnVtYmVyIG9mIHJlYXNvbnMsIGJ1
dCB0aGUgbW9zdA0KPj4+IGNvbW1vbiByZWFzb24gd2hlbiB1c2luZyBrcmI1aS9wIGlzIGEgR1NT
IHNlcXVlbmNlIG51bWJlciB3aW5kb3cNCj4+PiB1bmRlcnJ1bi4gV2hlbiBhbiB1bmRlcnJ1biBp
cyBkZXRlY3RlZCwgdGhlIHNlcnZlciBpcyBvYmxpZ2VkIHRvDQo+Pj4gZHJvcCB0aGUgUlBDIGFu
ZCB0aGUgY29ubmVjdGlvbiB0byBmb3JjZSBhIHJldHJhbnNtaXQgd2l0aCBhIGZyZXNoDQo+Pj4g
R1NTIHNlcXVlbmNlIG51bWJlci4gVGhlIGNsaWVudCBwcmVzZW50cyB0aGUgc2FtZSBYSUQsIGl0
IGhpdHMgaW4NCj4+PiB0aGUgc2VydmVyJ3MgRFJDLCBhbmQgdGhlIHNlcnZlciByZXR1cm5zIHRo
ZSBnYXJiYWdlIGNhY2hlIGVudHJ5Lg0KPj4+IA0KPj4+IFRoZSAic3RhdHAgKyAxIiBhcmd1bWVu
dCBoYXMgYmVlbiB1c2VkIHNpbmNlIHRoZSBvbGRlc3QgY2hhbmdlc2V0DQo+Pj4gaW4gdGhlIGtl
cm5lbCBoaXN0b3J5IHJlcG8sIHNvIGl0IGhhcyBiZWVuIGluIG5mc2RfZGlzcGF0Y2goKQ0KPj4+
IGxpdGVyYWxseSBzaW5jZSBiZWZvcmUgaGlzdG9yeSBiZWdhbi4gVGhlIHByb2JsZW0gYXJvc2Ug
b25seSB3aGVuDQo+Pj4gdGhlIHNlcnZlci1zaWRlIEdTUyBpbXBsZW1lbnRhdGlvbiB3YXMgYWRk
ZWQgdHdlbnR5IHllYXJzIGFnby4NCj4+PiANCj4+PiBUaGlzIHBhcnRpY3VsYXIgcGF0Y2ggYXBw
bGllcyBjbGVhbmx5IHRvIHY2LjUgYW5kIGxhdGVyLCBidXQgbmVlZHMNCj4+PiBzb21lIGNvbnRl
eHQgYWRqdXN0bWVudCB0byBhcHBseSB0byBlYXJsaWVyIGtlcm5lbHMuIEJlZm9yZSB2NS4xNiwN
Cj4+PiBuZnNkX2Rpc3BhdGNoKCkgZG9lcyBub3QgdXNlIHhkcl9zdHJlYW0sIHNvIHNhdmluZyB0
aGUgTkZTIGhlYWRlcg0KPj4+IHBvaW50ZXIgYmVmb3JlIGNhbGxpbmcgLT5wY19lbmNvZGUgaXMg
c3RpbGwgYW4gYXBwcm9wcmlhdGUgZml4DQo+Pj4gYnV0IGl0IG5lZWRzIHRvIGJlIGltcGxlbWVu
dGVkIGRpZmZlcmVudGx5Lg0KPj4+IA0KPj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4g
IyB2NS4xNisNCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3Jh
Y2xlLmNvbT4NCj4+PiAtLS0NCj4+PiBmcy9uZnNkL25mc3N2Yy5jIHwgICAgNCArKystDQo+Pj4g
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+IA0KPj4+
IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mc3N2Yy5jIGIvZnMvbmZzZC9uZnNzdmMuYw0KPj4+IGlu
ZGV4IGQ2MTIyYmIyZDE2Ny4uNjBhYWNjYTJiY2E2IDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mc2Qv
bmZzc3ZjLmMNCj4+PiArKysgYi9mcy9uZnNkL25mc3N2Yy5jDQo+Pj4gQEAgLTk4MSw2ICs5ODEs
NyBAQCBpbnQgbmZzZF9kaXNwYXRjaChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQ0KPj4+IGNvbnN0
IHN0cnVjdCBzdmNfcHJvY2VkdXJlICpwcm9jID0gcnFzdHAtPnJxX3Byb2NpbmZvOw0KPj4+IF9f
YmUzMiAqc3RhdHAgPSBycXN0cC0+cnFfYWNjZXB0X3N0YXRwOw0KPj4+IHN0cnVjdCBuZnNkX2Nh
Y2hlcmVwICpycDsNCj4+PiArIF9fYmUzMiAqbmZzX3JlcGx5Ow0KPj4+IA0KPj4+IC8qDQo+Pj4g
ICogR2l2ZSB0aGUgeGRyIGRlY29kZXIgYSBjaGFuY2UgdG8gY2hhbmdlIHRoaXMgaWYgaXQgd2Fu
dHMNCj4+PiBAQCAtMTAxNCw2ICsxMDE1LDcgQEAgaW50IG5mc2RfZGlzcGF0Y2goc3RydWN0IHN2
Y19ycXN0ICpycXN0cCkNCj4+PiBpZiAodGVzdF9iaXQoUlFfRFJPUE1FLCAmcnFzdHAtPnJxX2Zs
YWdzKSkNCj4+PiBnb3RvIG91dF91cGRhdGVfZHJvcDsNCj4+PiANCj4+PiArIG5mc19yZXBseSA9
IHhkcl9pbmxpbmVfZGVjb2RlKCZycXN0cC0+cnFfcmVzX3N0cmVhbSwgMCk7DQo+Pj4gaWYgKCFw
cm9jLT5wY19lbmNvZGUocnFzdHAsICZycXN0cC0+cnFfcmVzX3N0cmVhbSkpDQo+Pj4gZ290byBv
dXRfZW5jb2RlX2VycjsNCj4+PiANCj4+PiBAQCAtMTAyMyw3ICsxMDI1LDcgQEAgaW50IG5mc2Rf
ZGlzcGF0Y2goc3RydWN0IHN2Y19ycXN0ICpycXN0cCkNCj4+PiAgKi8NCj4+PiBzbXBfc3RvcmVf
cmVsZWFzZSgmcnFzdHAtPnJxX3N0YXR1c19jb3VudGVyLCBycXN0cC0+cnFfc3RhdHVzX2NvdW50
ZXIgKyAxKTsNCj4+PiANCj4+PiAtIG5mc2RfY2FjaGVfdXBkYXRlKHJxc3RwLCBycCwgcnFzdHAt
PnJxX2NhY2hldHlwZSwgc3RhdHAgKyAxKTsNCj4+PiArIG5mc2RfY2FjaGVfdXBkYXRlKHJxc3Rw
LCBycCwgcnFzdHAtPnJxX2NhY2hldHlwZSwgbmZzX3JlcGx5KTsNCj4+PiBvdXRfY2FjaGVkX3Jl
cGx5Og0KPj4+IHJldHVybiAxOw0KPj4+IA0KPj4+IA0KPj4+IA0KPj4gDQo+PiBXaXRoIHRoaXMg
cGF0Y2gsIEknbSBzZWVpbmcgYSByZWdyZXNzaW9uIGluIHB5bmZzIFJQTFkxNC4gSW4gdGhlDQo+
PiBhdHRhY2hlZCBjYXB0dXJlIHRoZSBjbGllbnQgc2VuZHMgYSByZXBsYXkgb2YgYW4gZWFybGll
ciBjYWxsLCBhbmQgdGhlDQo+PiBzZXJ2ZXIgcmVzcG9uZHMgKGZyYW1lICM5Nykgd2l0aCBhIHJl
cGx5IHRoYXQgaXMgdHJ1bmNhdGVkIGp1c3QgYWZ0ZXINCj4+IHRoZSBSUEMgYWNjZXB0IHN0YXRl
Lg0KPiANCj4gSSd2ZSByZXByb2R1Y2VkIGl0LiBMb29raW5nIG5vdy4NCg0KT25lIGxpbmUgZml4
IHdhcyBzcXVhc2hlZCBpbnRvICJORlNEOiBGaXggInN0YXJ0IG9mIE5GUyByZXBseSINCnBvaW50
ZXIgcGFzc2VkIHRvIG5mc2RfY2FjaGVfdXBkYXRlKCkiLiBUaGUgbmV3IHNlcmllcyBpcyBpbg0K
dGhlIG5mc2QtZml4ZXMgYnJhbmNoIG9mIG15IHJlcG8gb24ga2VybmVsLm9yZyA8aHR0cDovL2tl
cm5lbC5vcmcvPi4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
