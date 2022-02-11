Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F390A4B295E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349457AbiBKPsi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 10:48:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349442AbiBKPsi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 10:48:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D101A8
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 07:48:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BF8bTO023125;
        Fri, 11 Feb 2022 15:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GMoqPHKRgLpvaBboDaKLDG9mFoobx/F8rvS5/IPgeBU=;
 b=JEgKlnOwvemHShOGM+qWpzPruxcLUzykisbSNBthuvx3vVOtWDOHmR7dGfRvEbWR8fid
 rm6CHDDSl9OTewEaVGrA0OPSzLbvZr2RkqzEs6efqYPDDPr9gY2AuWmNKGQIiGbZv90/
 hqmIN3k3GIOW2A6UV4ohQX6XTTvOYyVIo+hXMedzTK0/3J+gQOGIHUpEbllQ5Od71l1D
 NnV8bEyVYAJrlfKJlVRZLrrN//wdZftLN/deb5oqOBl3BrVecDxPMZB/NDLJqQKx4q5T
 +DnRP7RIA9GPgtjxgaZKJaCT0/Nf+pDs4CfoBAgwGkX/wyQNiRXMiT/IlyUgFRtt36T8 Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5pmv8jjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 15:48:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BFfiB5146273;
        Fri, 11 Feb 2022 15:48:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 3e1h2cjn9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 15:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeDGqPVt+6yA8QghQqBlFZkEumXixBOYGq2i5ssPWKoOdTJLQafCRNwzoVpK1nzjTLR0KiPb0m79DcwTcHYQ6TZq2bTDgmHRz7TUmfpgHg5zR1N1gbOJmz3s7zZJezTlYwxEnpHgdqXlRlYVJsEv9jlOFWNrS3cxFalmvQJBHlfKyNM9TKNZXbxK9OjCBGZER4FqVPhO1nUPCZZGgIYWuKwuRgoZptEauk+VAbd8XQx32JI51+wx5mqVXhoDAeM2U4/JOmuve5zEMe95Pv5LAFGieNd0ZmFR8mDfXXYkqLoAuignz5BN8Gwwzb7F/y448WH2f36Bf6Sean+gxpX/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMoqPHKRgLpvaBboDaKLDG9mFoobx/F8rvS5/IPgeBU=;
 b=LI6113/0vG2Tzlu8zCVBk1VDKprfsIJOJj5kazhFHtjoJRMK4+jk7sXtNDf7WYOARM18jezrqkYB4GVyeBr5aZ/PuGfynVStUjqlTbEbySBg+IJEj8WJcDUjgRFRqzq3g7uB8Gs2gF7r/mQ1a9Cw2EDWXf6VMVb2aya9n1eOmdkQdbGuN2OcuW724tx5UlBx3bm6UJ+7UlGQxQC4GfGQ+g+Etl4xdzl+HrCK2bcHEZK2norW9gYYWXqsoaTVq45diQL6LH9v2PrEy0uBpliUAw2w5M+2S8SfoCa9GRVoDH7+rhKWzSgbQ/NxdW8pNIy7YIq0lE9AlKSlqACR2rODIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMoqPHKRgLpvaBboDaKLDG9mFoobx/F8rvS5/IPgeBU=;
 b=NSKf8Ay8opPuodYa/J7VJU9gnXCZaKMPPAslF6TxlaNS4iM1LU/2QvLTqp5Fl8F5XTCiq1/jPTuJQUdL1ilpFpmZEAY6Ye7XocPFDgTrqmUk+EzeJeKFbBEoTMxPsbJR6e3f7DDrqRlhFE2VpTAywwBg31AwHI4HxydlWbm0WLg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CO6PR10MB5473.namprd10.prod.outlook.com (2603:10b6:5:355::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 15:48:30 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 15:48:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@RedHat.com>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAA==
Date:   Fri, 11 Feb 2022 15:48:30 +0000
Message-ID: <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
In-Reply-To: <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a95cdd-35bc-484d-08a9-08d9ed75f3d3
x-ms-traffictypediagnostic: CO6PR10MB5473:EE_
x-microsoft-antispam-prvs: <CO6PR10MB5473343848A16776008DCB1E93309@CO6PR10MB5473.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2Nt4hJPjE/hh6LtJz+tl8+tGurF22/L9odZUkKpRZU5ego6wJYki7XEcWjtyQHSCpOeBLdT3uTJl7YzAXqloXql/R1ee/eibWbl79OVUQzFx2DmBFvOikzNjgMrhasZvtFhxNAw38bokix5glGmQTFxxFVHpMlwMUt61/aLLcQxl7CU6SnImoftoGVU9j7iUAfSIcA6b7sxFEa38oKckPYeXRqoITP3yAhEr0VzK9ozk1TYtcuIW1bKNKvKLvFT2qwLlX5oxg/NJX9AAMHWJxSzASWjCz1nLEMbG3Zc3qpF2a4wdxj4V7eS/9+jKpUqxuM8m8Bw3lX2Zl9aUDTTGMXkqLoXRaDo1Gz/fpR8VlsyMjcbm7OokjSZf8RdbV7JPI4IB3QbyGt+e8Vou+xq8saCVQgVXFXtfT3UpkYIQ7HFS9w+E3s7znq5+5oELrB4L1BNLgDxmb7ExDBb1SR8j4lk6ASwirp61s4hvkasMEjDKqikNKFij6IPcLnibjZ9jBgRxMWTXQEPCTSA0BTSAA4vofWVH3WDXSEEYkojNsyzuslhIh7t1yH4cZFlw6hrHKVWebDgDV8IP78/lbRI0ZIMWiFl8JB90OysjvRfAdHLk8w+XV6kaYXe1MdtXM4joRxKrkcdpvoVdC2qiWdXoX2RAhxWtlZEXh/8tjjGdajFRkJH47Gw/mlb+LNpG1H2KJXzVWcRiYRAs2M+eBBILzozGmp33X9w2ccH46JxnKgZscuH9tdirGKzMMKs5/y7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(8936002)(6512007)(26005)(66446008)(36756003)(53546011)(83380400001)(2616005)(64756008)(6506007)(33656002)(316002)(38100700002)(8676002)(66946007)(38070700005)(508600001)(6916009)(54906003)(122000001)(4326008)(5660300002)(86362001)(76116006)(71200400001)(2906002)(66556008)(6486002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gZs5VEQ3orvyjHNTQiOg7+WVevntw7i/LSbSjSlrhV+eiZ6+FnZO7gH2PjrQ?=
 =?us-ascii?Q?S+LLvIU0swir11/Eu6OhYlJbYx294Qyj+imGStnHxCLCYvzE8utF9mtGoVeD?=
 =?us-ascii?Q?8kZPoOtdqihAnq9uxQeYkoFBVehXOVSZKs8tzu7E3HCEfjScIrvbVL84CYV5?=
 =?us-ascii?Q?qj9M8n6blA4Qw/rwg4iiCGBXAUnRyNNoEr6YuYUSCIU0KSQUwzlqCPrUbbPC?=
 =?us-ascii?Q?zvxB9XPYD6MSenb5peRip3s8hQDiNILVVBxobb6IDzWPODYDKbCGiNVIHIZl?=
 =?us-ascii?Q?CYmKPG0obPDU9VYc4OOMmVyFibxRlJvTzB2lzfJbDUkneB1DsY/YAitEmtpd?=
 =?us-ascii?Q?GcHLzL+J+FHbssBg0b7GBoUNc1OzMVkTXPGsv9T/ZfEjMi1B79Yjf2YiTeHm?=
 =?us-ascii?Q?MebXu91LE+lyxeL47KTmH0jVG44w85S6mhMYbY83O0WMN1I1+Ew+yyFd+w4l?=
 =?us-ascii?Q?je/dDFxFsgjIvxvN1b9X4OIrqSn7OUbISBWQCIyr+Arim0r1XYYordEBe+cT?=
 =?us-ascii?Q?Q4rZitXwVd6IrfX8+5edX2PCfBS8UAiQDriXTSUNgZIrIBxbi2zsdoR5MjrB?=
 =?us-ascii?Q?9sBdkHNinEz0edEOdcOefd3HKFiEpJ7xAqnCKTT8q9Af4zd1cHR+m2LSprYI?=
 =?us-ascii?Q?0OVp6ZdT6HShXkIIKWZQZm4TY6+IGXuUi1PXwzRMxcm5b97PfcnLxgL4Cjse?=
 =?us-ascii?Q?UbF/So66MPrB9R6/gQB7lwUx4TMz6cKdRTAfu+OGsxk0TF8T6wCnMesv88e/?=
 =?us-ascii?Q?N8A1ZsOI9nhowiuEK1h1ihs8cKD6fmauxRliSa+0zoTZiOSYwGKhJ/iJ+BHH?=
 =?us-ascii?Q?li3pi/gxTmBJmHYmYlN/mu3zCtgX/4YXzFUC6DWlkeMkm7GmneLrNR0rpbKv?=
 =?us-ascii?Q?C8PMhrcA3DSgYqtlfjnJyKEcT0kOYHu0gFt5oygJp4BAmkd/IHhKVJQH25cN?=
 =?us-ascii?Q?XRXftgfHd4wmG1KSD3gUB2NoSVnLBLCKP1St/1fAZdyRXDrRHoTVxg3dWL07?=
 =?us-ascii?Q?V83NNLnPx0Hjqqs1rohRr3paINiTRhEbLygYHS/GWmzn5pJ6phKyNpiLP2uJ?=
 =?us-ascii?Q?zQHTHjvgpTjCC4gSfQAEf0Euz6u7ip7/Y1Hrx/v2k16DUflJ7a7ii5/n2Qrm?=
 =?us-ascii?Q?jIEj4agJlP/maYbAdbXvrpTFpAoJQgr6dGhbYiwWXO+M9VFuNoxUAREGgB2E?=
 =?us-ascii?Q?NS0aANEFP1gWpFN6xczlD4FTLBHKc/cMyrRG3OQLatznJlOG9bZOBLGUq4RQ?=
 =?us-ascii?Q?X8Er9vaL463TJf5RJQoJsUSSqau/GrmApRe55CZgfzgSkUShdlz8PrFUMOCL?=
 =?us-ascii?Q?n5ZHFD9CuqxOYwKavXwmz4V65TTtvVO8t7TF8c0cC/kLGiSvH48QGvLUQHod?=
 =?us-ascii?Q?3oA8Vx2SeHgzWKaVxhLVg+5lObNy6Ebfb9b8vd97h5UcnEuibz0OVlKLwI3D?=
 =?us-ascii?Q?5rUFrjNPUOeCjDVaAGSKuE2noI3OPsBcA9UVXDwc/K6KrqLQwM2Mzxm8UC13?=
 =?us-ascii?Q?Hfb4cRwGWzXSHih0Wg5pJqz61ENfrmNVhVPzAasuvwyRTRo3zKAm9Nkn4cmn?=
 =?us-ascii?Q?dtGjGxCp92at/2CCamFxk28kBtf+FJeRElgh8MhpJW66YUluE78e3e/oWmkw?=
 =?us-ascii?Q?bKwycQT4WCoNJ+QXN3au30Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <332EB32C56A5624F93948CF090C77B71@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a95cdd-35bc-484d-08a9-08d9ed75f3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 15:48:30.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUPedvNc4ujo5GrmvaWEJaK+C5uXhb2CTm0cl0L36ruSlB2V/BcUjb9JCYgJucOMlMgioDbBf1L7A1P9pPPe1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5473
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=816 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110085
X-Proofpoint-GUID: iOhPKttOAIOtUqr6VTT5Q3_isTmjQZuR
X-Proofpoint-ORIG-GUID: iOhPKttOAIOtUqr6VTT5Q3_isTmjQZuR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 11, 2022, at 8:44 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>=20
> On 2/10/22 1:15 PM, Chuck Lever III wrote:
>>> On Feb 10, 2022, at 1:01 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> The nfsuuid program will either create a new UUID from a random source =
or
>>> derive it from /etc/machine-id, else it returns a UUID that has already
>>> been written to /etc/nfsuuid or the file specified.  This small,
>>> lightweight tool is suitable for execution by systemd-udev in rules to
>>> populate the nfs4 client uniquifier.
>> I like everything but the name. Without context, even if
>> I read NFS protocol specifications, I have no idea what
>> "nfsuuid" does.
> man nfsuuid :-)

Any time an administrator has to stop to read documentation
is an unnecessary interruption in their flow of attention.
It wastes their time.


>> Possible alternatives:
>> nfshostuniquifier
>> nfsuniquehost
>> nfshostuuid
> I'm good with the name... short sweet and easy to type.

I'll happily keep it short so it is readable and does not
unnecessarily inflate the length of a line in a bash script.
But almost no-one will ever type this command. Especially
if they don't have to find its man page ;-p

My last serious offers: nfsmachineid nfshostid

I strongly prefer not having uuid in the name. A UUID is
essentially a data type, it does not explain the purpose of
the content.


--
Chuck Lever



