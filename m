Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED74B5744
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiBNQmg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 11:42:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiBNQmU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 11:42:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5633F65168
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 08:42:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EG6YxR021646;
        Mon, 14 Feb 2022 16:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q1GaN7rp3xVa+A1EecCc+tP5htZbpucnCDYlprM4Iio=;
 b=R0RNiuxwvRcUFUqHr4pojSDVh2ZtbwPe7X8ndgWveKxWaV/PgndgoDQdPlUYbP405iu1
 NFDXlz/EEMlvA9xPt3C4COxkjzWNKldpar7+6GC9x71UN/RW8MJiedsIEUXGv9d6zgP+
 k19PbaSCFLnD7R61ki/ZnB6trGSEfTroTr2CBZXmVIdbmvogiD1PaPuec+q6SBTRrJBI
 UW+VJm8aHw70ItVOrDD97Id5C505Ajjqe6R/FUubWBCV2B51ZJMGL5CwgShDVibp1Nh8
 f6hZeEkV4JZ1+OtYEUx8YCmQi8fMRKTbSYlAqL/NAHDYnETs2pbF6Ufint3BBSyiyF4W qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p255th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 16:41:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EGa3wL159228;
        Mon, 14 Feb 2022 16:41:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3e6qkwyn4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 16:41:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkmM18iwdrCJu5bU7AtalNHeYENP/jHS+AiRHAEDSBpTMgxBHO62Ai5LQ8wzb6pY3mceQ3GRyZl2iPtDVB1j363/tsDszHkH1gwAFzSdBdEJhS7M+PKuexmQTmgAo2TatlpTwYBNdzYgFgLD6Oe317RYP6GjMxmRMeL2a0N76qQb+N759sa78OORDgL0YpOtgCAATddxVJW6epargnInlphlSKVDA1jSC8oQpyqrIVkexch7nfSVSThyhrOhel7Ls5Gswu41qHCkDpHhkCbghvz9ZcRFb7wHxTSAI9XCqfOtqmch+YQDII3lMoqTR2uaTHbJa10V3/r5T3sIjaS9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1GaN7rp3xVa+A1EecCc+tP5htZbpucnCDYlprM4Iio=;
 b=eM7TlCkR/DZYLEFw9ZgsgkYbVTmq0nwqCmDeM2FatNKGQHcnaShI+P9yRzj2pelbb7VEbUR7sfo/uHh50ViFTU158y79hrJwO/h9S+3qlZ8b3Dp6w6XTsdLgLG0rgS2MBZHhnlNEVpfrSB4pH8pN5Vfdzaf0o7lFUajGtTcVLjn2CgzNDjlmukbS9DdD0Vv8hDHH+F0V+ob5efE50HJMU6Q4Z+zxyC7fyuKl8gy9WDcpTZn51Vq/3mVqFeCOKQaPRSDSgFQ73b4SbYoiOOmPrDQkYcRx/JkcWWif0HXaTf7Sp+7AFh0UYisDqS87LUBNVxFGvEdjiZeJyXTf8VUQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1GaN7rp3xVa+A1EecCc+tP5htZbpucnCDYlprM4Iio=;
 b=difotZARu/2G/tU3zdNimvl1P+B8EZy/Wgbl1wgmq7VIyAIgIbTjBmTDOXLK0miYDwAAwhT4SJs2xRf8qJcWknb59dxmJtO6rZ+qjq+UdPNMcVjX6A2wmenKH5enhTefYDXv06JcC0kvYe49sHOOKJiA/L8mOxj37c+MEQGOhJ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR1001MB2407.namprd10.prod.outlook.com (2603:10b6:910:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 16:41:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 16:41:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thomas Blume <tblume@suse.com>
CC:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Topic: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Index: AQHYIYhKDk3jkCVie0yBKH6y3YG1OqyTK2AAgAAP9ACAAAUSgA==
Date:   Mon, 14 Feb 2022 16:41:38 +0000
Message-ID: <45A65BD8-8712-4B43-A91E-9DBA21ECE6E3@oracle.com>
References: <20220214092607.24387-1-Thomas.Blume@suse.com>
 <F1A91E0B-4544-4739-ADAD-CF9FCC9E8F66@oracle.com>
 <q7n3pnn5-6o3-524-8rn1-q7oprr139258@fhfr.pbz>
In-Reply-To: <q7n3pnn5-6o3-524-8rn1-q7oprr139258@fhfr.pbz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6550c440-659c-4321-ae6a-08d9efd8df56
x-ms-traffictypediagnostic: CY4PR1001MB2407:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2407571CFE5AC8437D6F9C9593339@CY4PR1001MB2407.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGGG5MSHGOTXfPfgx7msvXDcarppISKKepFx6rl2BucggZr2ATJF2oVtAm8X46gec0mopFFdo8v+YrJktoXf4e3how27A78Nl+2xYc34eCMCkswt+nusyDmkAUrP+o4Ib2iw+6qVoJfxNbAHzUaZz8G16SKECk6u0a6p5D2HT/p9WfevdsDR0Ia1UAgJLq3t8/bHQbDlGNCaTJ8I5BURVUap0iyhX1EID+XQlJxl5Wk5hIM6h/dvFcyEmFp89ga9U6plaqhHMP3ZgqeOjykAPY8IGHW7pn03/1+NaKMS0gC6CbvQrqMLRoFL7/hJ1hqjiHNoEH4x7TxNXGBWJy4CCXEALqKugm/8mXw5+f7r0LeArgQhw9DiKZM5DB53LH4aiYa5cIXO+9jsqqcRvKmX62U1dUanmGL08mB05gTtJWh7PEQ3H0qffHfo+o7PoebuQcQlVYpd2kmbQsnWKSec+irxd4Ks2BMjfs7nnhPv+NZ4zE5W9cqzT/yLTypncqK/raXGz3iqoOwMLf/OiNHw1grEqNimxNwMBLzWw8B9Ntl+fQK5TEXm4S6yvkm8I9/Wc2+gN1oMITTjBhW4qp25Gr09THaHtfCBXJuX7acNla3f4Dw5nvL7ruoJyg1IxNpkgYoJtC81niPkc6mCJyon70nMzPs+JXRTmXmYPa6dJrmz5G6HM9KgGyHpwJmaHGmittvVHHbeeeuQYJtZbLGP07rJuLZQuMZXnitoWkQREeDmEkVaqKlLaXWjevkm51nyOKarItP75MWiAs8bbhPMxXZUk/5FvW4CITrl2hN6diiEyfagvnmTXtJHUWZdjfXG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66556008)(54906003)(2616005)(8936002)(122000001)(508600001)(83380400001)(316002)(66946007)(6916009)(2906002)(53546011)(186003)(64756008)(38100700002)(8676002)(26005)(66476007)(66446008)(33656002)(86362001)(91956017)(966005)(6506007)(6512007)(5660300002)(6486002)(36756003)(71200400001)(38070700005)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CUqLI91m3E5RhDQXvgADSx7l464P8IbXNG9fz3+Z5UzDLJaeQt3p2FzfTolW?=
 =?us-ascii?Q?3Vqkq4J+/S9Iij9oa6LKPx3lrOhRsP8415WX/vDUQxgKr0XbCF9eRWzVLSoA?=
 =?us-ascii?Q?OpV2hwmAtEjLzbhHuDxnlQb1NPMifGqytcldPzv1tjBErqcG4RC10Nxy2wAF?=
 =?us-ascii?Q?AZLIJA5WF8CEqWe57lH7GJuoP5xGsmPg0HU4Gll6/+m/gM3CALM4wqie0OT/?=
 =?us-ascii?Q?n0qVOk7gO6coKpc7JAv/stKXeoWZEaVE427xiaqHszP5+ErAASadiWct8llj?=
 =?us-ascii?Q?O2rMn8opiVwsmuqqAa9CGnwsfZFitdlTJtqTo59vtNUo11ttUWxnLwPUp82y?=
 =?us-ascii?Q?bliVSMc6thwajMRjT0fqgqrljZtCGKFkp48aVF3xw0cQXnvl0adT6cLTndl9?=
 =?us-ascii?Q?g98ePN1R79o5mluondnDmsld13TvwGUHjpWTdrWdE8xCHhcGo30tENrCdR/8?=
 =?us-ascii?Q?yoNE31jr26rkrfc+FA91zbvvhTK6THtW2Ye8uxcajx8J8Uu/qzwTNgBTYSC/?=
 =?us-ascii?Q?53Pvm9eA0W983HRvKLyhMOevgcQZM1VZ41sgKLgWirTRpjJAQypkumsuZPdP?=
 =?us-ascii?Q?oZ973GEhZrYcM3b3lv4xNIUQzIyXjTdIWsyQx4QnSM986prYr7uhdRm8SKQL?=
 =?us-ascii?Q?0domvj96m7Ex92acbr2C0OQlCP0aBVB6fTV4aiYy5tcUOB+qErcwsDgdG/Ep?=
 =?us-ascii?Q?+3T6KFKho2UqcP57ctnJXfT90QZWZfhrsoJXIvhyVopmPqkzTv3uwsUt6rW6?=
 =?us-ascii?Q?BPz3Z0Yc6UJqKFjveObpw9i/3L1+ans4+l4HeP5SSfRIEDyCVwUqS8XYcVi1?=
 =?us-ascii?Q?84WCnPkZiTdB5fdwbrVam6X11X+xZ/FFkrmPa8B+Hr6siHJDn8neL9MLYEzG?=
 =?us-ascii?Q?zFLspCxEukT4toLcc3jDSr/1L4w227Z4YuvhvDo0tJz51epb+nfxOT9y2IJ/?=
 =?us-ascii?Q?xmZlrK9mb6oU+nRdekWraxqxu/jMu0Pwug+aD94SjWnX2KKSS20/HmItfMAW?=
 =?us-ascii?Q?RdjLC0JpTdWu8SfrYh5q1r4upFEPqp6rZtQ7tlSZU6wsUVqRIZbMYCNeQ2ea?=
 =?us-ascii?Q?PDHZgfNtAkkyCZwdBHzC3BrXXX6B+By2i5Z1DOcUpCNRM/5gC3bLBpYSdqs5?=
 =?us-ascii?Q?4WTjOTq3wz2nb5Eci3t0ZPTmZbZkB5wiiFvmGZknfhCa4K5GXmkvc8Tt3b7I?=
 =?us-ascii?Q?4m2aEn5n0cWOTFSiBGo3ZUjy7pKwKP6mM8InRWDw7jRfN9z+AXZOMsugatqX?=
 =?us-ascii?Q?zcDViZXvj79FP1W8PV+EbKJ394lkvD3z7kobVXn9UTii0dYqcUpE0qoH1nKL?=
 =?us-ascii?Q?lLS3mba8dlDHv4I6q+srG0C4X2UnBrvnlq8dHadJlASRKyguGFXjA3IjS5Bk?=
 =?us-ascii?Q?kSSUnR+4u10bUC/UB0MLE0e1DA/jBn05hvE18+2YYf62rBd4nQvWFYAbnPLs?=
 =?us-ascii?Q?M06b+lt3xAckLoKiFmK3/NDPNluin7pugUY56OLdaf2YDzouGlVxnWZB4jM/?=
 =?us-ascii?Q?bz1Rv9w9a6Sy62QjSIJOyp0EsllObdgyDaAInX+NqcNeYwOoUCBYRGVyRX7U?=
 =?us-ascii?Q?zWepxq0JFsYBeocyNVSXHoeSUup14oSGYzPyUjps8wfqTVDM9VWYez6+O5kh?=
 =?us-ascii?Q?OGrgVzJFc+29jqG/oiQyxNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC33AD4B9E99D6448D6C9EF342BC3987@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6550c440-659c-4321-ae6a-08d9efd8df56
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 16:41:38.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ki7MCfGd2gcVwdLNVptcxv6MfiBKQ7RjOJeIClbarj2hET3ztNjntbFVCRkIZpqA2uUZJrWHnvXUUtomun3wCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2407
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140099
X-Proofpoint-ORIG-GUID: EddcjaDxP8wzDIg1AzwXW8idlG2kQJ9v
X-Proofpoint-GUID: EddcjaDxP8wzDIg1AzwXW8idlG2kQJ9v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2022, at 11:23 AM, Thomas Blume <tblume@suse.com> wrote:
>=20
> Hello Chuck,
>=20
> On Montag 2022-02-14 16:26, Chuck Lever III wrote:
>=20
>>> On Feb 14, 2022, at 4:26 AM, Thomas Blume via Libtirpc-devel <libtirpc-=
devel@lists.sourceforge.net> wrote:
>>>=20
>>> In some setups, it is necessary to try rpc protocol version 2 first.
>>=20
>> Before applying this, I hope we can review previous discussions of
>> this issue. I've forgotten the reason some users prefer it, or
>> maybe I'm just imagining we've discussed it before :-)
>=20
> We've had a discussion about 1 year ago:
>=20
> https://sourceforge.net/p/libtirpc/mailman/message/37227894/
>=20
> actually that encouraged me to send a patch, even though I initially thou=
ght
> is wasn't good enough for upstream.

I agree that adding the sidecar file to toggle the rpcbind
version order is a bit rough.


>> The patch description, at the very least, has to have a lot more
>> detail about why this change is needed. Can it provide a URL to
>> threads in an email archive, for example?
>=20
> This goes back to an old SUSE bugreport following the change of rpc proto=
col
> version 2, 3, 4 to 4, 3, 2.
> Below an description of issue the customer was seeing:
>=20
> -->
> An 3rd party NFS Server is behind a F5 front end load balancer device.
> The F5 front end load balancer device is replacing IP addresses in packet=
s as
> they head to a NFS server.
> It replaces IP addresses in headers but as you might expect it does not r=
eplace
> the IP address within the RPC data payload, i.e. within RPC GETADDR reque=
st,
> which places an address there for the universal address or hint.  Without=
 a
> correct hint, the GETADDR reply which comes back gives an unexpected addr=
ess
> which happens to be unroutable from the nfs client's point of view.
> --<
>=20
> We agreed that this is rather an issue of the loadbalancer hardware, but =
we
> would have to address that anyway due to backward compatibility.
>=20
> So, the first question is, do we want to stay backward compatible upstrea=
m?
> We have to do that as distributor, but of course upstream is different.

Thanks for the reminder. I suggest that it should be included
in the patch description if you post again so that it becomes
part of the libtirpc commit history.


>>> Creating the file  /etc/netconfig-try-2-first will enforce this.
>>=20
>> A nicer administrative API would enable you to update the whole
>> rpcbind version order, but that might be more work than you want
>> to pursue.
>>=20
>> It would be a nicer if, instead of a separate file, a line is
>> added to /etc/netconfig to toggle this behavior, or provide the
>> whole version order. E.g.
>>=20
>> # rpcbind 4 3 2
>>=20
>> # rpcbind 2 4
>>=20
>> Really, though, this isn't related to the transport definitions
>> in /etc/netconfig, so a separate configuration file might be
>> more appropriate.
>=20
> Thanks for the hints, if you deem a patch would be still desireable I wil=
l work
> on that.

I'd like to hear other opinions. I'm not the maintainer of
libtirpc, I'm just someone who is very opinionated :-)


--
Chuck Lever



