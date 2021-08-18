Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BDC3F09A6
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Aug 2021 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhHRQ4Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Aug 2021 12:56:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31558 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhHRQ4P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Aug 2021 12:56:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IGpGkq017426;
        Wed, 18 Aug 2021 16:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gTn7Eo/UKclXXMDOds8xIbecaU1d+mzi/yXso8XmELw=;
 b=P1PrN75SaHECbQ5c6mb6hKbZCeERwSx/FHI8MshaKbKjTCOVdtNZjIo06+5WrkCoa3Uk
 i2ozWd3o12VPhKN74eu7OB+8sOiryh5ziQ74ddjV9aGAfG2wtI+2WMhVtvDtQKAozWG1
 IKNqG9QgDJMef5K3avSJfjIfKYANc+5y6CQ36wRa/rDMs9E9xyFJcZDypHGwUiUJVj0T
 dC8dQM2/lGPEoxN+C/MnD6ht5AUayXLo9hVhmO24pUH2YK1DaWgMeWNxtNONwnn4LIYl
 GKxLAqO/jUVeHISYy1svta8SnSkCusyh8wokpMQKR9vxRz/8zlbDW+mSY98cX+hwL+Fj GA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gTn7Eo/UKclXXMDOds8xIbecaU1d+mzi/yXso8XmELw=;
 b=tvwg0EZ3bsnUu4fYA107JJyWIIu+T9ZthQCu7bkYUvVVRTL8l9P5zzjfs41hqJThRuCh
 PF765CVwZKrJmuuVPwB+2+9TrtnVb3hQlu6DA5sq9IqvxnZBjQeyw5OHlsMmbV2Ii/HU
 /XFf8fPCMlo5aCmsrGEtzbuzTkdiykhltHouIbu8MTvnLssCPNqjUF4+WOvwuPX819w7
 EkV4xUULNyz6wDflp5GUow5YgPQm1bBCS9zhXN1YUmHFbW5kqu3lNjy7ajWXYYft938V
 7UxRGU3HauPRCkiIVz3oLdC9xGrCnEGqhhbRbvlVAOVlsjuOUainwM723TKKmW6H3iyu Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmh3cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:55:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17IGt5Vc150257;
        Wed, 18 Aug 2021 16:55:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by aserp3030.oracle.com with ESMTP id 3ae3vht6dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:55:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOBw3x/o2CWpUW/NeFbed80Qy0BFd16WWZj0fQqChLF1eH/CUUkV5BZTFJV1rQeAzsn7T/chy1Dze5tYFN6BGwoqXZLOhU9pQv+dy8nMl69l5LN/zoiwvzixokirjxcVvkWQykY4GeY54Vz5s1YuZlA/X/gd3/E+DcaqVzNz5YHr2uY+FHIqsyTy3vLl3t6m8W9uoZvKiB0uXOa4BNDM9bpmBCuS5xxyRzSbXKE1MJBw5UOGhRCMEfRnri6601CVVanTotBcbWpFskckv+MznH5wd4J1fC13CP5tNHNm6mZSeyoBxyik7WlrHTOziOASwjsfkms+SUxcL3qX6e0NCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTn7Eo/UKclXXMDOds8xIbecaU1d+mzi/yXso8XmELw=;
 b=dCwqt+3apbb6bPnd6xRuNqXyyt2SkbvGEtyoCPXk2x4PCUMIgV9eje+bJ2AmkU6BqaArSullryu0aIgus3by+rCBgfUONJN67qDX1qqRTtSCSVIi2BnIKCzMU8y+Gxi4WKbvdVMjxSFM+ssqXgo7E2/SgNobMopCTaD1cHBCime+88gUYtpEZ0p5ga962elTfgva6uiGi20wrdXgFMrDo7Yh2MW3cGrs6Zn5Bw0oI6zkU2O6vk3otLVCFWPVJIx29VOZHS8drD0UayJNnAQ+m2jdWShXd7IcbJOfAhc2o/5EWTDaBVZmFEqeeMVvpGnHkR4eVWW93RfPtKlv6Iim6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTn7Eo/UKclXXMDOds8xIbecaU1d+mzi/yXso8XmELw=;
 b=juCUdu+9TTuxP2xm5PhVl21/5l8xZLMFURP6A5z5R8+sKwHje96OTmN+PGm4dKS/L6IaPJVt56IaMgyXjw7BzO9aY+NQwzEZ1yQXMIOMj18kxfOhLUQbaJznmIi6TdsqfZN8BbYuLnu7wlGCbCu87kDy497nBy4cYf9mcdg0URc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2487.namprd10.prod.outlook.com (2603:10b6:a02:b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 16:55:32 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 16:55:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIABnm2AgAgMfgCAAAwogIAAEeKAgAACzoCAASrTgA==
Date:   Wed, 18 Aug 2021 16:55:32 +0000
Message-ID: <0233D762-14A0-4BC5-91DC-5ECB455E908F@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
 <7B44D7FD-9D0F-4A0D-ABE9-E295072D953F@oracle.com>
 <97fe445e-6c4f-b7cf-fa39-fd0c4222a89e@rothenpieler.org>
 <baf4f3b0-6717-8e3d-efd5-fa471ae8e7e3@oracle.com>
 <94a7f911-84bd-f250-526e-054649a00f23@oracle.com>
In-Reply-To: <94a7f911-84bd-f250-526e-054649a00f23@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12662c8c-e98e-4ad1-4e57-08d96268fdbe
x-ms-traffictypediagnostic: BYAPR10MB2487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB248738C11D1FCB32CCB0A2FC93FF9@BYAPR10MB2487.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urH7GJyRZfCOQ8OIeEPxpcGBMtBYk6eK0kcQRlfC7u2ZBLTJdHkT47Njf7F69ZTpGe2myy9pvslyotjEVQf89h8b6UHtH9SLUcKEpAuX8UmqVHwmE8gzR9DFj0hVnWJWeY3fL1ChXBYgFhnwSNOFRg5AsyUHLvarX1WtT41Mb4axpOdySLW8eDvUeOclExWMflrfzL3vAs9RemCgPmoKvhuCRIUwy/cYCYFGsqXoggTmG9o++g29SZzQcp7h1PtXoeffcGzvUTVTM1dy1sqHVnnv4V7w60deGVO82ZEdy3ckRjz55vhz/CqZGtZcMjDbP/lgCC0BEEGNjukDpgg9EQA/jlGZo5rwE4nmSMHpfpB6KtwrNckr12L7V5julHDyuou+W1J96kiDbVKCDfk3TfNqI1YheKcoMnGnXb/tWGYn6In617PJXNFZeJB6Y6Q0n4VyhkTjo5e5TyqY35UnaqhmzZ7suH5IYDoi/bhR0Zi4IUC+C9wr5y6pCiIgdAakIkfSwNamN91qw9KhKjK5BIDujaOAVmgQX8N/Odx9Or4f/rbm7aUW5LUrYpUhuVkkiiAYuFf9gEolsk4MelcgJN5KRI2fN7/QErwnJWLQ6C6ofxMrxfgJE90I8rtk2IDKZgZCzPqNffoPGVGkc8d8jLnwxrDj/NYQfSc66ml1Xs8PqmBOiepLwMddyc5ZeKxPNj6mXl5to+E5+OaCxmfzAlgrPwFLU7HB+mY9/Ewvxbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(396003)(376002)(6486002)(53546011)(6506007)(91956017)(26005)(186003)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006)(86362001)(6512007)(5660300002)(478600001)(8676002)(38070700005)(2616005)(4326008)(36756003)(6636002)(122000001)(71200400001)(54906003)(8936002)(33656002)(37006003)(6862004)(38100700002)(316002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2vboPGfFApT+59MdtRCSdGgpEensquC3+ulE9ykKBInsBrahruj08q+fsNP0?=
 =?us-ascii?Q?VHeAPszkBP+ZxgbknmU6G4TikP7nbTkn0rmEKCPcoQjN3N7v9LnxtXdrVIqB?=
 =?us-ascii?Q?bXI2ekSqyKBBtPZp+kc57yTsKaUUzowgjTfolA2UeFvOWzd4uYKVUlssXxIZ?=
 =?us-ascii?Q?yB+tBvqmzUzCYKdAYcIt1WRRuG7iUZ/+rViXo7yaAjpevYj+sk7ZQDhdx1L8?=
 =?us-ascii?Q?zrGkNC/rpRMKfbXIDXNCSllIP90ujCZvy68TKyzXLROnt9B39htDU2iscdUa?=
 =?us-ascii?Q?tzENOYV0N6kiIMVWObknezCcU7NajXFoX8GThHA0F79QT5UuJD812AmJzbQ8?=
 =?us-ascii?Q?TRcJz2lUZMULRkYegnCl7tCb2hyOfFUDlciOSCH+K7wX4xEtgjKY/pL2llOo?=
 =?us-ascii?Q?nCuxpsTY36wCKSGcEpuB5wC8Xkl0QoEA5oFcEZm3kX6XGQiTU/99LViDi52q?=
 =?us-ascii?Q?eZbn/FXREL4kPQ///dDxpAS9ieWzkCOvw8NWInSpFM/7NXcP9pK7CoCr+8qV?=
 =?us-ascii?Q?AjMUAuv2OKWMITZ6ihoQESsh57gNB3dIUTXvbJUCl8P2Eirp/V9EHM3dNTVk?=
 =?us-ascii?Q?KCGgFvRiBHq5TPz6TdusrwvmYI/PY9g/jSUYC91uuYnSdwMwq/vFvIoyAJfj?=
 =?us-ascii?Q?CED6LC5LuFnbyCC1/Ich3d15jFFaTa/HoZvqrkeg41+oiHo5MD7XGNxUXLnY?=
 =?us-ascii?Q?PZ/c7ZWHWvUMCzC4Pee8UySsFVxMQgfudLB0TyEEKI7wRQs5cFMXGKoVRuCZ?=
 =?us-ascii?Q?YQIloJ6TtKESd0yawBub+22OHMK3OvllnIL+m9h3VFcy+2MwtnWk2TFnkDtX?=
 =?us-ascii?Q?tW7p9B0dERdb1uqI/n3R7bCg+FrofmIEzQFzGnIXzl3nmGcIMs9EeQMUVseh?=
 =?us-ascii?Q?g870lEpnzju+mIRP8Y0SrvQLkiEToewIWOIWmVDRyuZZ5qkF+tfsV9z/evIz?=
 =?us-ascii?Q?coWv5awhX2ZqRyx5Cluluij0us4JriFeWdbvb7ZviFeSjI7gQ0ocgApTLnbm?=
 =?us-ascii?Q?TsScCShvbh26ePYFuPTTj+lLnunpuov5yKj/SeQnIigTfwX3ydB9T/REwnYp?=
 =?us-ascii?Q?jIWaptAXx1tvOycnhtnzF9MhHrOXk9a2EfH3f79eKA6nBajVz7WFC2tIR+7v?=
 =?us-ascii?Q?tyKYkw06CuzxFzKYb1c6oDyulM9IQeLeg7f5PqKy+PlJY1nmWMZYUC3PT+LT?=
 =?us-ascii?Q?+DpWkJQ3Uy1t0bkVPXGi+QUJMAvVy5X1jWfJF+UOW2j7vLWjvU2Yhd6/09eG?=
 =?us-ascii?Q?6POCXf+GB+Fv1rXWMGIvKYJ6DcywHSfFmvLIRcMhwFg/H+DN0wrW0wFf+TpE?=
 =?us-ascii?Q?NUBc8PRQIjwbfP2KgAwuuJ6f?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <337ED81272030241A0698CC9E773EDF9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12662c8c-e98e-4ad1-4e57-08d96268fdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 16:55:32.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6Xa0Mn8qX7wTFItB9530xeyAenabGzl/GHK8O4ENnIbFkK4m81Fxdn+QFgFyoftAdlJ7lE+RgogMSQPwb2dgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2487
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180106
X-Proofpoint-ORIG-GUID: dMQQ7obBTtvq6bdJepkw22UErde6fqet
X-Proofpoint-GUID: dMQQ7obBTtvq6bdJepkw22UErde6fqet
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 17, 2021, at 7:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 8/17/21 3:55 PM, dai.ngo@oracle.com wrote:
>>=20
>> On 8/17/21 2:51 PM, Timo Rothenpieler wrote:
>>> On 17.08.2021 23:08, Chuck Lever III wrote:
>>>> I tried reproducing this using your 'xfs_io -fc "copy_range
>>>> testfile" testfile.copy' reproducer, but couldn't.
>>>>=20
>>>> A network capture shows that the client tries CLONE first. The
>>>> server reports that's not supported, so the client tries COPY.
>>>> The COPY works, and the reply shows that the COPY was synchro-
>>>> nous. Thus there's no need for a callback, and I'm not tripping
>>>> over backchannel misbehavior.
>>>=20
>>> Make sure the testfile is of sufficient size. I'm not sure what the thr=
eshold is, but if it's too small, it'll just do a synchronous copy for me a=
s well.
>>> I'm using a 50MB file in my tests.
>>=20
>> The threshold for intra-server copy is (2*rsize) of the source server.
>=20
> The threshold for inter-server copy is (14*rsize). This restriction is to=
 be removed in the next merge.
>=20
> e-Dai
>=20
>> Any copy smaller than this is done synchronously.

Thank you, Dai, that helped. I was able to reproduce with a 200MB
source file on an xfs-backed export. Looking at the issue now.


--
Chuck Lever



